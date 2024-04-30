#!/usr/bin/env bash

for plugin in $(cat changed-plugins.txt); do
  # Define filename
  filename="updated-plugin-2.8-3.4-${plugin}.yaml"

  # Generate rules file
  yaml_content=$(cat <<YAML
rules:
  plugin-update-check-${plugin}:
    description: "Check for plugins with schema changes for 3.x are configured"
    message: "Plugin '${plugin}' has had a schema change for Kong 3.4 and may need updating"
    given: \$..plugins[*].name
    severity: warn
    then:
      field: "@"
      function: pattern
      functionOptions:
        match: "^${plugin}"
YAML
)

  # Write to file
  echo "${yaml_content}" | tee "rules/plugins/${filename}"
done
