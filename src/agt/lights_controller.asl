// lights controller agent

/* Initial beliefs */

// The agent has a belief about the location of the W3C Web of Thing (WoT) Thing Description (TD)
// that describes a Thing of type https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Lights (was:Lights)
td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Lights", "https://raw.githubusercontent.com/Interactions-HSG/example-tds/was/tds/lights.ttl").

// The agent initially believes that the lights are "off"
lights("off").

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: the agents believes that a WoT TD of a was:Lights is located at Url
 * Body: greets the user
*/
@start_plan
+!start : td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Lights", Url) <-
    .print("Initializing Lights Controller Agent");
    makeArtifact("lightsController", "org.hyperagents.jacamo.artifacts.wot.ThingArtifact", [Url], ArtId).

@turn_on_lights_plan
+!turn_on_lights : lights_state("off") <- 
    .print("Turning on the lights");
    .send(personalAssistant, tell, lights(on)); //for Task 1.3, notify Personal Assistant
    invokeAction("lightsController", "https://was-course.interactions.ics.unisg.ch/wake-up-ontology#SetState", ["on"]);
    -+lights_state("on").

@turn_off_lights_plan
+!turn_off_lights : lights_state("on") <- 
    .print("Turning off the lights");
    .send(personalAssistant, tell, lights(off)); //for Task 1.3, notify Personal Assistant 
    invokeAction("lightsController", "https://was-course.interactions.ics.unisg.ch/wake-up-ontology#SetState", ["off"]);
    -+lights_state("off").

    
/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }