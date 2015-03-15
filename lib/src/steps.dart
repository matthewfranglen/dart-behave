part of behave;

// The steps section handles the implementation of steps.
// It can load them
// It can execute them
// It can pass parameters
// It can handle context

class StepLoader {
  final StepRepository steps;

  StepLoader() : steps = new StepRepository();

  void load(Object instance) {
    InstanceMirror instanceMirror = reflect(instance);

    steps.getTypes().forEach(_loadType(instanceMirror));
  }

  _TypeFunction _loadType(InstanceMirror instance) =>
    (Type type) {
      instance.type.declarations.values
        .where(_isMethod)
        .map(_castToMethodMirror)
        .where(DeclarationAnnotationFacade.filterByAnnotation(type))
        .forEach(_addStep(type, instance));
    };

  static bool _isMethod(DeclarationMirror mirror) =>
    mirror is MethodMirror;

  static MethodMirror _castToMethodMirror(DeclarationMirror mirror) =>
    mirror as MethodMirror;

  _MethodMirrorFunction _addStep(Type type, InstanceMirror mirror) =>
    (MethodMirror method) {
      StepImplementation step = new StepImplementation(mirror, method);

      new DeclarationAnnotationFacade(method)
        .getAnnotationsOf(type)
        .forEach((BehaveAnnotation annotation) {
          steps.addStep(type, annotation.value, step);
        });
    };
}

class StepRepository {
  final Map<Type, Map<String, StepImplementation>> steps;

  StepRepository() : steps = {
    Given: {},
    When: {},
    Then: {}
  };

  void addStep(Type type, String description, StepImplementation step) {
    steps[type][description] = step;
  }

  bool hasStep(Type type, String description) =>
    steps.containsKey(type) && steps[type].containsKey(description);

  StepImplementation getStep(Type type, String description) =>
    steps[type][description];

  Iterable<Type> getTypes() =>
    steps.keys;
}

class StepImplementation {
  final InstanceMirror _instance;
  final MethodMirror _method;

  StepImplementation(InstanceMirror instanceMirror, MethodMirror methodMirror)
    : _instance = instanceMirror,
      _method = methodMirror;

  void invoke(Map<String, dynamic> context, ContextFunction previousStep) {
    if (_hasPreviousStepParameter()) {
      _invokeWithPreviousStep(context, previousStep);
    }
    else {
      _invokeWithoutPreviousStep(context, previousStep);
    }
  }

  ContextFunction asContextFunction(ContextFunction previousStep) =>
    (Map<String, dynamic> context) {
      invoke(context, previousStep);
    };

  bool _hasPreviousStepParameter() =>
    _method.parameters.length == 2;

  void _invokeWithPreviousStep(Map<String, dynamic> context, ContextFunction previousStep) {
    _instance.invoke(_method.simpleName, [context, previousStep]);
  }

  void _invokeWithoutPreviousStep(Map<String, dynamic> context, ContextFunction previousStep) {
    previousStep(context);
    _instance.invoke(_method.simpleName, [context]);
  }
}

typedef void ContextFunction(Map<String, dynamic> context);
typedef void _MethodMirrorFunction(MethodMirror method);
typedef void _TypeFunction(Type type);

// vim: set ai et sw=2 syntax=dart :
