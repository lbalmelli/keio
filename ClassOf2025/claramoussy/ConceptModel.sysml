package FoldingSeatMetroSystem {

    enum OccupancyLevel { NOT_CROWDED; CROWDED; }
    enum SeatState { FOLDED; DEPLOYED; }

    out port crowdLevel: OccupancyLevel;

    part user {
        out port deployRequest: Boolean;
    }

    part controller {
        in port crowdIn: OccupancyLevel;
        in port userRequest: Boolean;
        in port seatOccupied: Boolean;
        in port timeElapsed: ScalarValues::Real;

        out port allowDeployment: Boolean;
        out port crowdOverride: Boolean;
        out port idleTimeout: Boolean;

        action decideDeployPermission(
            decidedeploymentdermission: OccupancyLevel,
            request: Boolean
        ) : Boolean {
            return (crowd == NOT_CROWDED & request == true);
        }

        action monitorCrowdOverride(decidedeploymentpermission: OccupancyLevel) : Boolean {
            return (crowd == CROWDED);
        }

        action checkIdleTimeout(
            checkoccupied: Boolean,
            checktimeElapsed: ScalarValues::Real
        ) : Boolean {
            return (occupied == false & timeElapsed > 30.0);
        }
    }

    part crowdSensor {
        out port crowdOut: OccupancyLevel;

        action senseCrowd;
    }

    part seat {

        in port allowDeployment: Boolean;
        in port crowdOverride: Boolean;
        in port idleTimeout: Boolean;

        out port seatOccupied: Boolean;
        out port timeElapsed: ScalarValues::Real;

        private attr currentState: SeatState;

        part ceilingMount;

        part telescopicArm {
            connect to ceilingMount;
        }

        part seatUnit {
            part presenceSensor {
                out port detected: Boolean;
            }

            part foldButton {
                out port pressed: Boolean;
            }

            connect seatUnit to telescopicArm;
        }

        part handle {
            part deployButton {
                out port pressed: Boolean;
            }
        }

        part seatTimer {
            out port elapsed: ScalarValues::Real;
        }

        // === Mechanical Actions ===
        action deploySeat {
            doc
            /* Deploys the seat by extending the telescopic arm and rotating the seat unit to horizontal position. */
        }

        action foldSeat {
            doc
            /* Folds the seat by retracting the telescopic arm and rotating the seat unit to vertical position. */
        }

        // === Internal structural connections ===
        connect telescopicArm to ceilingMount;
        connect handle to ceilingMount;
        connect seatTimer to seat;

        // === Functional connections ===
        connect telescopicArm.seatUnit.presenceSensor.detected -> seatOccupied;
        connect seatTimer.elapsed -> timeElapsed;

        state def SeatBehavior {
            state FOLDED {
                state foldedState;
                transition to DEPLOYED
                    when (allowDeployment == true)
                    do deploySeat;
            }

            state DEPLOYED {
                state deployedState;
                transition to FOLDED
                    when (allowDeployment == false)
                    do foldSeat;
            }
        }
    }

    // === Global system connections ===
    connect crowdSensor.crowdOut to controller.crowdIn;
    connect user.deployRequest to controller.userRequest;
    connect seat.seatOccupied to controller.seatOccupied;
    connect seat.timeElapsed to controller.timeElapsed;
    connect controller.allowDeployment to seat.allowDeployment;
    connect controller.crowdOverride to seat.crowdOverride;
    connect controller.idleTimeout to seat.idleTimeout;
}
