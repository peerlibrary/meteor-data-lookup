Package.describe({
  name: 'peerlibrary:data-lookup',
  summary: "Reactively lookup a field in the object",
  version: '0.2.0',
  git: 'https://github.com/peerlibrary/meteor-data-lookup.git'
});

Package.onUse(function (api) {
  api.versionsFrom('METEOR@1.4.4.5');

  // Core dependencies.
  api.use([
    'coffeescript@2.0.3_3',
    'ecmascript',
    'underscore',
    'tracker'
  ]);

  // 3rd party dependencies.
  api.use([
    'peerlibrary:computed-field@0.8.0'
  ]);

  api.export('DataLookup');

  api.mainModule('lib.coffee');
});

Package.onTest(function (api) {
  api.versionsFrom('METEOR@1.4.4.5');

  // Core dependencies.
  api.use([
    'coffeescript@2.0.3_3',
    'ecmascript',
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
    'peerlibrary:classy-test@0.3.0',
    'peerlibrary:server-autorun@0.7.0'
  ]);

  api.addFiles([
    'tests.coffee'
  ]);
});
