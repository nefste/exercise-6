// blinds controller agent

/* Initial beliefs */

// The agent has a belief about the location of the W3C Web of Thing (WoT) Thing Description (TD)
// that describes a Thing of type https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Blinds (was:Blinds)
td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Blinds", "https://raw.githubusercontent.com/Interactions-HSG/example-tds/was/tds/blinds.ttl").

// the agent initially believes that the blinds are "lowered"
blinds("lowered").

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: the agents believes that a WoT TD of a was:Blinds is located at Url
 * Body: greets the user
*/
@start_plan
+!start : td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Blinds", Url) <-
    .print("Initializing Blinds Controller Agent");
    makeArtifact("blindsController", "org.hyperagents.jacamo.artifacts.wot.ThingArtifact", [Url], ArtId).


@raise_blinds_plan
+!raise_blinds : blinds_state("lowered") <-
    .print("Raising the blinds");
    .send(personalAssistant, tell, blinds(raised));
    invokeAction("blindsController", "https://was-course.interactions.ics.unisg.ch/wake-up-ontology#SetState", ["raised"]);
    -+blinds_state("raised").

@lower_blinds_plan
+!lower_blinds : blinds_state("raised") <- 
    .print("Lowering the blinds");
    .send(personalAssistant, tell, blinds(lowered));
    invokeAction("blindsController", "https://was-course.interactions.ics.unisg.ch/wake-up-ontology#SetState", ["lowered"]);
    -+blinds_state("lowered").


/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }