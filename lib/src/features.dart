part of behave;

// The features section handles the feature files.
// It can read them
// It can turn them into individual steps
// It can compose those steps into tests
// It can run those tests
// It can use inherited context data from the global environment

class FeatureLoader {

}

// Represents the 'before' in any part of the test. So the feature is before the scenario. The scenario is before the steps. The given is before the when...
abstract class _SurroundingContext {
  String describe();
  ContextFunction asContextFunction();
}

class Feature implements _SurroundingContext {
  final List<ContextFunction> _before;
  final StepLoader _loader;
  final String description;

  Feature(this.description)
    : _before = [],
      _loader = new StepLoader();

  void load(Object instance) {
    _loader.load(instance);
  }

  Scenario scenario(String description) =>
    new Scenario(this, _loader.steps, description);

  String describe() => "Feature: ${description}\n";

  ContextFunction asContextFunction() =>
    (Map<String, dynamic> context) {
      _before.forEach((ContextFunction before) {
        before(context);
      });
    };
}

class Scenario implements _SurroundingContext {
  static final String _keyword = "Scenario";
  final _SurroundingContext feature;
  final StepRepository steps;
  final String description;
  final List<ContextFunction> _before;

  Scenario(this.feature, this.steps, this.description) : _before = [];

  GivenStep given(String statement) =>
    new GivenStep("Given", statement, this, steps);

  WhenStep when(String statement) =>
    new WhenStep("When", statement, this, steps);

  ThenStep then(String statement) =>
    new ThenStep("Then", statement, this, steps);

  String describe() => "${feature.describe()}${_keyword.padLeft(9)}: ${description}\n";

  ContextFunction asContextFunction() =>
    (Map<String, dynamic> context) {
      feature.asContextFunction()(context);
      _before.forEach((ContextFunction before) {
        before(context);
      });
    };
}

// vim: set ai et sw=2 syntax=dart :
