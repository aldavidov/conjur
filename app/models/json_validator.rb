# frozen_string_literal: true

class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, _, _)
    @record = record
    return unless @record.json_data.present?

    @record.errors.add(:json_data, missing_params_message) unless missing_params.empty?
    @record.errors.add(:json_data, extra_params_message) unless extra_params.empty?
  end

  private

  def json_parameters
    @json_parameters ||= @record.json_parameters
  end

  def extra_params
    @extra_params ||= @record.json_data.select { |key, _| !json_parameters.include?(key) }
  end
  
  def missing_params
    @missing_params ||= @record.json_parameters.select { |key, _| !@record.json_data.key?(key) }
  end

  def missing_params_message
    format("missing parameters: %s", missing_params.keys.join(','))
  end

  def extra_params_message
    format("extraneous parameters: %s", extra_params.keys.join(','))
  end
end
