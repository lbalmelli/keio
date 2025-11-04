package FoldingSeatMechanicalPOC {

    enum SeatState { FOLDED; DEPLOYED; }

    part FoldingSeat {

        private attr currentState: SeatState;

        // === STRUCTURAL COMPONENTS ===

        part ceilingMount {
            doc
            /* 
             * Fixed support attached to the ceiling.
             * Chosen component: Aluminum ceiling plate with steel anchors.
             * Rationale: lightweight, corrosion-resistant, rigid enough for repeated use.
             */
        }

        part handle {
            doc
            /* 
             * Handle used by the passenger to deploy the seat.
             * Chosen component: Polycarbonate handle with integrated tactile push button.
             * Rationale: ergonomic, robust, low-cost and intuitive for users in public environments.
             */

            part deployButton {
                doc
                /* 
                 * Button that mechanically triggers seat deployment.
                 * Chosen component: IP65-rated tactile push button.
                 * Rationale: weatherproof, vandal-resistant, durable.
                 */
            }

            connect handle to ceilingMount as mount01 {
                doc
                /* 
                 * Type: Fixed joint (no degrees of freedom).
                 * Assembly: bolted connection between handle bracket and aluminum ceiling plate.
                 * Rationale: ensures rigidity and prevents unwanted movement.
                 */
            }
        }

        part telescopicArm {
            doc
            /* 
             * Telescopic arm extending vertically to deploy the seat.
             * Chosen component: Gas-spring assisted steel arm with linear guide rails.
             * Rationale: smooth motion, controlled speed, self-damping, no external power required.
             */

            connect telescopicArm to ceilingMount as slide01 {
                doc
                /* 
                 * Type: Sliding joint (1 DOF - linear translation).
                 * Assembly: telescopic guide with gas spring integrated in vertical axis.
                 * Rationale: provides stable and safe controlled extension and retraction.
                 */
            }
        }

        part seatUnit {
            doc
            /* 
             * Main seating surface that folds around a hinge.
             * Chosen component: ABS-molded seat with stainless steel bracket.
             * Rationale: fire-retardant, lightweight, durable, easy to clean for metro environments.
             */

            part foldButton {
                doc
                /* 
                 * Button located under the seat to manually fold it back.
                 * Chosen component: Low-profile dome push button.
                 * Rationale: discreet, responsive, resistant to heavy public use.
                 */
            }

            connect seatUnit to telescopicArm as hinge01 {
                doc
                /* 
                 * Type: Pivot joint (1 DOF - rotation).
                 * Chosen component: Steel hinge with spring return.
                 * Rationale: automatic retraction when released, avoids powered folding system.
                 */
            }
        }

        part seatTimer {
            doc
            /* 
             * Internal timing module used to detect idle time of the seat.
             * Chosen assembly: Integrated rigid mount fixed within seatUnit.
             * Rationale: protects electronics, limits vibrations, easy maintenance.
             */
        }

        // === MECHANICAL ACTIONS ===
        action deploySeat {
            doc
            /* 
             * Extends the telescopic arm (slide01) and rotates the seat (hinge01)
             * from vertical (FOLDED) to horizontal (DEPLOYED) position.
             * Mechanical sequence:
             *   1. Gas spring extends telescopic arm.
             *   2. Pivot hinge rotates seat to deploy position.
             */
        }

        action foldSeat {
            doc
            /* 
             * Retracts the telescopic arm (slide01) and pivots the seat (hinge01)
             * back to vertical (FOLDED) position.
             * Mechanical sequence:
             *   1. Seat released by user or sensor command.
             *   2. Spring hinge assists in smooth retraction to folded position.
             */
        }

        // === BEHAVIORAL REPRESENTATION ===
        state def MechanicalBehavior {
            state FOLDED {
                doc
                /* Seat folded against the wall — stable configuration. */
                transition to DEPLOYED
                    when (user_action == 'deploy')
                    do deploySeat;
            }

            state DEPLOYED {
                doc
                /* Seat unfolded and ready for use. */
                transition to FOLDED
                    when (user_action == 'fold')
                    do foldSeat;
            }
        }
    }
}
