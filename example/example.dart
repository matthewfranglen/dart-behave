library behave.example;

import 'package:unittest/unittest.dart';
import 'package:behave/behave.dart';

void main() {
  Feature feature = new Feature("Behave examples");

  feature.load(new Steps());

  feature.scenario("Demonstrating given when and then")
    .given("an initial state")
    .when("I perform the action under test")
    .then("the correct outcome is observed")
    .test();

  feature.scenario("Demonstrating the context")
    .given("a default context")
    .when("I add a string to the context")
    .then("the string is available in subsequent steps")
    .test();

  feature.scenario("Using and")
    .given("an initial state")
    .and("an additional quality about the initial state")
    .when("I perform the action under test")
    .and("that action may involve multiple steps")
    .then("the correct outcome is observed")
    .and("and the observation may involve multiple parts")
    .test();
}

class Steps {

  @Given("an initial state")
  void givenAnInitialState(Map<String, dynamic> context) {
    // Here you would perform any steps required to initialize the environment which are not currently under test.
  }

  @Given("a default context")
  void givenADefaultContext(Map<String, dynamic> context) {
    // The context object is passed to every method and is the same throughout a single test. You can store anything in it.
    // It is created before the test starts, so this step doesn't have to do anything to provide "a default context".
  }

  @Given("an additional quality about the initial state")
  void givenAnAdditionalQualityAboutTheInitialState(Map<String, dynamic> context) {
    // Even though this method was invoked with .and(...) it is indistinguishable from any other @Given step.
  }


  @When("I perform the action under test")
  void whenIPerformTheActionUnderTest(Map<String, dynamic> context) {
    // Here you would perform the single action under test. Use the context to store any results which need to be checked in the @Then step.
  }

  @When("I add a string to the context")
  void whenIAddAStringToTheContext(Map<String, dynamic> context) {
    context['a string'] = 'another string';
  }

  @When("that action may involve multiple steps")
  void whenThatActionMayInvolveMultipleSteps(Map<String, dynamic> context) {
    // Even though this method was invoked with .and(...) it is indistinguishable from any other @When step.
  }


  @Then("the correct outcome is observed")
  void thenTheCorrectOutcomeIsObserved(Map<String, dynamic> context) {
    // This is where you would check the results of the action to see if they are as desired.
  }

  @Then("the string is available in subsequent steps")
  void thenTheStringIsAvailableInSubsequentSteps(Map<String, dynamic> context) {
    // Use the unittest library to actually assert the results. The unittest library is already being used to run the tests and print the results.
    expect(context['a string'], equals('another string'));
  }

  @Then("and the observation may involve multiple parts")
  void thenAndTheObservationMayInvolveMultipleParts(Map<String, dynamic> context) {
    // Even though this method was invoked with .and(...) it is indistinguishable from any other @Then step.
  }
}
