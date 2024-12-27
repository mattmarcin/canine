class AddOns::Save
  extend LightService::Action
  expects :add_on
  promises :add_on

  executed do |context|
    add_on = context.add_on
    apply_template_to_values(add_on)
    fetch_package_details(add_on)
    add_on.save
  end

  def self.fetch_package_details(add_on)
    if add_on.helm_chart?
      result = AddOns::HelmChartDetails.execute(query: add_on.metadata['helm_chart.name'])
      if result.failure?
        add_on.errors.add(:base, "Failed to fetch package details")
        return
      end
      package = result.response['packages'].find { |package| package['package_id'] == add_on.metadata['package_id'] }
      add_on.metadata['package_details'] = package
    end
  end

  def self.apply_template_to_values(add_on)
    # Merge the values from the form with the values.yaml object and create a new values.yaml file
    add_on.values.extend(DotSettable)

    variables = add_on.metadata['template'] || {}
    variables.keys.each do |key|
      variable = variables[key]

      if variable.is_a?(Hash) && variable['type'] == 'size'
        add_on.values.dotset(key, "#{variable['value']}#{variable['unit']}")
      else
        variable_definition = add_on.chart_definition['template'].find { |t| t['key'] == key }
        if variable_definition['type'] == 'integer'
          add_on.values.dotset(key, variable.to_i)
        else
          add_on.values.dotset(key, variable)
        end
      end
    end
  end
end
