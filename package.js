Package.describe({
  name: 'peerlibrary:data-lookup',
  summary: "Reactively lookup a field in the object",
  version: '0.1.0',
  git: 'https://github.com/peerlibrary/meteor-data-lookup.git'
});

Package.onUse(function (api) {
  api.versionsFrom('METEOR@1.0.3.1');

  // Core dependencies.
  api.use([
    'coffeescript',
    'underscore',
    'tracker'
  ]);

  // 3rd party dependencies.
  api.use([
    'peerlibrary:computed-field@0.3.1'
  ]);

  api.export('DataLookup');

  api.addFiles([
    'lib.coffee'
  ]);
});

Package.onTest(function (api) {
  // Core dependencies.
  api.use([
    'coffeescript',
    'random',
    'underscore',
    'reactive-var'
  ]);

  // Internal dependencies.
  api.use([
    'peerlibrary:data-lookup'
  ]);

  // 3rd party dependencies.
  api.use([
    'peerlibrary:classy-test@0.2.24',
    'peerlibrary:server-autorun@0.5.2'
  ]);

  api.addFiles([
    'tests.coffee'
  ]);
});
