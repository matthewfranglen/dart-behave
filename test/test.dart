library behave.test;

import 'package:unittest/unittest.dart';
import 'package:behave/behave.dart';

void main() {
  Feature feature = new Feature("Source Code based feature declaration");

  feature.load(new Steps());

  feature.scenario("Changing the context")
    .given("a default context")
    .when("I add a number to the context")
    .then("the number is available in subsequent steps")
    .test();

  feature.scenario("Changing the context")
    .given("a default context")
    .when("I add a string to the context")
    .then("the string is available in subsequent steps")
    .test();

  feature.scenario("Skipping given")
    .when("I add a number to the context")
    .then("the number is available in subsequent steps")
    .test();

  feature.scenario("Skipping when")
    .given("a default context")
    .then("the number is not available in subsequent steps")
    .test();

  feature.scenario("Skipping then")
    .given("a default context")
    .when("I add a number to the context")
    .test();

  feature.scenario("Using and")
    .given("a default context")
    .and("a puppy")
    .when("I add a number to the context")
    .and("I add a string to the context")
    .then("the number is available in subsequent steps")
    .and("the string is available in subsequent steps")
    .test();
}

class Steps {

  @Given("a default context")
  void givenDefaultContext(Map<String, dynamic> context) {}

  @Given("a puppy")
  void givenAPuppy(Map<String, dynamic> context) {
    // It's adorable!
  }

  @When("I add a number to the context")
  void addNumberToContext(Map<String, dynamic> context) {
    context["number"] = 42;
  }

  @When("I add a string to the context")
  void addStringToContext(Map<String, dynamic> context) {
    context["string"] = "string";
  }

  @Then("the number is available in subsequent steps")
  void testForNumberInContext(Map<String, dynamic> context) {
    expect(context["number"], equals(42));
  }

  @Then("the number is not available in subsequent steps")
  void testForNumberNotInContext(Map<String, dynamic> context) {
    expect(context["number"], equals(null));
  }

  @Then("the string is available in subsequent steps")
  void testForStringInContext(Map<String, dynamic> context) {
    expect(context["string"], equals("string"));
  }
}
