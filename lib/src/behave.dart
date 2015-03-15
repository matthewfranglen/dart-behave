part of behave;

// The behave section handles the language of the api.
// This provides a way to create and compose the given, when, then statements.
// This provides a way to describe the full test statement thus composed.



// given("foo")
//   .when("bar")
//     .then("baz")
//       .test()
//
// given, when, and then create lambdas that is finally executed by the test().
// Given, when, and then are implemented three classes, allowing and to return the current class:
//
// given("foo").and("faz")
//   .when("bar").and("war")
//     .then("baz").and("waz")
//       .test()
//
// The step implementations are annotated. They are loaded using the scenario:
//
// scenario("testing foo bar baz", steps: TestSteps)
//   .given("foo").and("faz")
//     .when("bar").and("war")
//       .then("baz").and("waz")
//         .test()

abstract class Step implements _SurroundingContext {
  final String keyword;
  final String description;
  final _SurroundingContext previous;
  final StepImplementation impl;

  Step(this.keyword, this.description, this.previous, this.impl);

  String describe() =>
    "${previous.describe()}${keyword.padLeft(9)} ${description}\n";

  void test() {
    unittest.test(describe(), () {
      _run({});
    });
  }

  void _run(Map<String, dynamic> context) {
    impl.invoke(context, previous.asContextFunction());
  }

  ContextFunction asContextFunction() => this._run;
}

class GivenStep extends Step {
  StepRepository _repo;

  GivenStep(String keyword, String description, _SurroundingContext previous, StepRepository repo)
    : super(keyword, description, previous, repo.getStep(Given, description)),
      _repo = repo;

  GivenStep and(String description) =>
    new GivenStep("And", description, this, _repo);

  WhenStep when(String description) =>
    new WhenStep("When", description, this, _repo);

  ThenStep then(String description) =>
    new ThenStep("Then", description, this, _repo);
}

class WhenStep extends Step {
  StepRepository _repo;

  WhenStep(String keyword, String description, _SurroundingContext previous, StepRepository repo)
    : super(keyword, description, previous, repo.getStep(When, description)),
      _repo = repo;

  WhenStep and(String description) =>
    new WhenStep("And", description, this, _repo);

  ThenStep then(String description) =>
    new ThenStep("Then", description, this, _repo);
}

class ThenStep extends Step {
  StepRepository _repo;

  ThenStep(String keyword, String description, _SurroundingContext previous, StepRepository repo)
    : super(keyword, description, previous, repo.getStep(Then, description)),
      _repo = repo;

  ThenStep and(String description) =>
    new ThenStep("And", description, this, _repo);
}

// vim: set ai et sw=2 syntax=dart :
