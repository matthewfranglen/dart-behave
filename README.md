Behave
======

A Behaviour Driven Development framework for Dart testing.

Introduction
------------

Behaviour Driven Development is a process for developing software which
emphasizes a ubiquitous language between stakeholders. This language is used to
define the acceptance criteria that the software must meet. This library
provides some support for executing such acceptance criteria.

Currently the Gherkin parser has not been completed so tests must be defined in
code.

Synopsis
--------

Start by defining a Feature and loading some Steps:

    Feature feature = new Feature("Source Code based feature declaration");

    feature.load(new Steps());

Features contain scenarios which consist of steps. A complete scenario is a
complete test and can be executed.

    feature.scenario("Changing the context")
      .given("a default context")
      .when("I add a number to the context")
      .then("the number is available in subsequent steps")
      .test();

The step definitions are looked up in the loaded objects based on annotations:

    class Steps {

      @Given("a default context")
      void givenDefaultContext(Map<String, dynamic> context) {}

      @When("I add a number to the context")
      void addNumberToContext(Map<String, dynamic> context) {
        context["number"] = 42;
      }

      @Then("the number is available in subsequent steps")
      void testForNumberInContext(Map<String, dynamic> context) {
        expect(context["number"], equals(42));
      }

Description
-----------

Tests are made of Features which contain Scenarios which consist of Steps.

A Feature represents a specific piece of functionality that the software
provides. The scenarios describe specific aspects of that functionality. The
steps are the individual statements that combine to form that description.

    Feature feature = new Feature("Source Code based feature declaration");

    feature.load(new Steps());

    feature.scenario("Changing the context")
      .given("a default context")
      .when("I add a number to the context")
      .then("the number is available in subsequent steps")
      .test();

Steps are indicated using _given_, _when_ and _then_. Once a scenario has been
defined you execute the test by calling _test()_.

The steps are converted into code using the loaded steps. The feature loads
steps by inspecting objects passed in using the _load_ method. The steps are
recognized based on annotations on the methods. Every annotation must have a
text description, and the associated step method will be called when a step
with that description is encountered.

The different step types represent semantic differences in the statements. A
_given_ statement should set up the state prior to the test. A _when_ statement
should perform the action which is under test. A _then_ statement should verify
the outcome of that test.

This library uses unittest to implement the tests, so functions like _expect_
are available and should be used.

    Feature feature = new Feature("Source Code based feature declaration");

    feature.load(new Steps());

    ...

    class Steps {

      @Given("a default context")
      void givenDefaultContext(Map<String, dynamic> context) {}

      @When("I add a number to the context")
      void addNumberToContext(Map<String, dynamic> context) {
        context["number"] = 42;
      }

      @Then("the number is available in subsequent steps")
      void testForNumberInContext(Map<String, dynamic> context) {
        expect(context["number"], equals(42));
      }

A feature can contain many scenarios:

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

    ...

The _and_ keyword can be used to add additional steps. These steps will always
be of the same type as the previous step.

    feature.scenario("Using and")
      .given("a default context")
      .and("a puppy") // here and means given
      .when("I add a number to the context")
      .and("I add a string to the context") // here and means when
      .then("the number is available in subsequent steps")
      .and("the string is available in subsequent steps") // here and means then
      .test();

Example Code
------------

Example code is available in the _example_ directory.


TODO
====

 * Reading features written in Gherkin
 * Scenario Outlines and Examples
 * Backgrounds

