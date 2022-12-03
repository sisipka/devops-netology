
// this file returns the params for the current qbec environment
local env = std.extVar('qbec.io/env');
local paramsMap = {
  _: import './environments/base.libsonnet',
  default: import './environments/default.libsonnet',
  stage: import './environments/stage.libsonnet',
  prod: import './environments/prod.libsonnet',
};

local prod = prod {
  components +: {
    backend +: {
      replicas: 3,
    },
  }
};

local paramsMap = import 'glob-import:environments/*.libsonnet';
local baseFile = if env == '_' then 'base' else env;
local key = 'environments/%s.libsonnet' % baseFile;

if std.objectHas(paramsMap, key)
then paramsMap[key]
else error 'no param file %s found for environment %s' % [key, env]
