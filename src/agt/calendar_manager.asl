// calendar manager agent

/* Initial beliefs */

// The agent has a belief about the location of the W3C Web of Thing (WoT) Thing Description (TD)
// that describes a Thing of type https://was-course.interactions.ics.unisg.ch/wake-up-ontology#CalendarService (was:CalendarService)
td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#CalendarService", "https://raw.githubusercontent.com/Interactions-HSG/example-tds/was/tds/calendar-service.ttl").

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: the agents believes that a WoT TD of a was:CalendarService is located at Url
 * Body: greets the user
*/
@start_plan
+!start : td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#CalendarService", Url) <-
    .print("Initializing Calendar Manager Agent");
    makeArtifact("calendarService", "org.hyperagents.jacamo.artifacts.wot.ThingArtifact", [Url], ArtId);
    !read_upcoming_event.


/* Plan: read upcoming event */
@read_upcoming_event_plan
+!read_upcoming_event : true <-
    readProperty("calendarService", "https://was-course.interactions.ics.unisg.ch/wake-up-ontology#ReadUpcomingEvent", UpcomingEventList);
    .wait(5000); // waits 5 seconds before trying to read the upcoming event again
    !handle_upcoming_event(UpcomingEventList).

/* Plan: handle upcoming event */
@handle_upcoming_event_plan
+!handle_upcoming_event(UpcomingEventList) : .size(UpcomingEventList, Size) & Size > 0 <-
    .print("Upcoming event detected:", UpcomingEventList);
    .send(personalAssistant, tell, upcoming_event(Event)); //for Task 1.3, notify Personal Assistant
    .wait(60000); // wait 1 min to check for upcoming events
    !read_upcoming_event.

+!handle_upcoming_event(UpcomingEventList) : .size(UpcomingEventList, Size) & Size == 0 <-
    .print("No upcoming events detected");
    .wait(60000); 
    !read_upcoming_event.


/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }
