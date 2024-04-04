// personal assistant agent

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: true (the plan is always applicable)
 * Body: greets the user
*/
@start_plan
+!start : true <-
    .print("Hello world").

// Plan: handle lights state information
+!inform : content(lights(State)) <- 
    .print("Lights are now", State).
// Plan: handle blinds state information
+!inform : content(blinds(State)) <- 
    .print("Blinds are now", State).

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }