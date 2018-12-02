use <helpers.scad>

module attachment_ball() {
    // Import the ball attachment from stl
    import("include/attachments/ball.stl");
}


module attachment_insert38() {
    // Import the cutout used for a 3/8 UNC thread-insert
    // We can also scale this to "fake" different thread sizes
    import("include/attachments/insert.stl");
}


module attachment_empty() {
    // Import an "empty" attachment (just a cylinder)
    import("include/attachments/empty.stl");
}


module add_attachments(attachment_indices,
                       attachment_spots,
                       attachment_orientations) {
    // Place the attachments indicated by attachment_indices at places indicated
    // by attachment_spots, oriented by attachment_orientations.
    // attachment_indices :       list of integers. Integers correspond to the
    //                            following attachments:
    //                            0 : no attachment
    //                            1 : 3/8 UNC insert
    //                            2 : ball
    // attachment_spots :         list of vectors, pointing to the locations of
    //                            the inserts. Needs same length as
    //                            attachment_indices.
    // attachment_orientations :  list of vectors describing rotations. The
    //                            attachments are rotated like this. Needs same
    //                            length as attachment_indices.

    n_attachments = len(attachment_indices);

    // Make sure we got vectors of the same length
    if (let(l1 = len(attachment_spots),
            l2 = len(attachment_orientations))
        (n_attachments != l1) || (n_attachments != l2)) {
            error_msg("add_attachments: Received vectors of different lengths!");
    }

    index = attachment_indices[0];
    spot = attachment_spots[0];
    orient = attachment_orientations[0];

    if (n_attachments == 1) {
        place_attachment(index, spot, orient) children(0);
    }
    else {
        remain_attachment_indices =      [for (i=[1:n_attachments-1])
                                            attachment_indices[i]];
        remain_attachment_spots =        [for (i=[1:n_attachments-1])
                                            attachment_spots[i]];
        remain_attachment_orientations = [for (i=[1:n_attachments-1])
                                            attachment_orientations[i]];

        place_attachment(index, spot, orient)
            add_attachments(remain_attachment_indices,
                            remain_attachment_spots,
                            remain_attachment_orientations)
                children(0);
    }
}


module place_attachment(attachment_id, position, orientation, negative=false) {
    // Add the attachment attachment_id to the handle (first child) at position
    // with orientation. If negative is true, the empty attachment is subtracted
    //from the handle first. (For attachments that "go into" the handle like
    // inserts).
    // attachment_id :  int
    //                  0 : no attachment
    //                  1 : 3/8 UNC insert
    //                  2 : ball
    // position :       vector
    // orientation :    rotation-vector
    // negative :       bool
    // children :       (0) : Handle
    if (attachment_id == 0) {   // empty attachment
        union() {
            children(0);
            translate(position) rotate(orientation) attachment_empty();
        }
    }
    else if (attachment_id == 1) { // 3/8 UNC insert
        union() {
            difference() {
                children(0);
                translate(position) rotate(orientation) attachment_empty();
            }
            translate(position) rotate(orientation) attachment_insert38();
        }
    }
    else if (attachment_id == 2) { // ball
        union() {
            children(0);
            translate(position) rotate(orientation) attachment_ball();
        }
    }
    else {
        error_msg(str("place_attachment: Unrecognized attachment id: ", attachment_id));
    }
}

add_attachments([0,1,2],
                [[50,0,0],[0,0,50],[0,50,0]],
                [[0,90,0],[0,0,0],[-90,0,0]])
                    cube(100, center=true);
