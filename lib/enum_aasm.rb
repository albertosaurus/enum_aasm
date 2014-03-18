require "enum_aasm/version"
require 'power_enum'
require 'aasm'
require 'aasm/base'
require 'aasm/persistence/active_record_persistence'
require 'aasm/persistence/base'

AASM::Persistence::ActiveRecordPersistence::InstanceMethods.module_eval do

  def aasm_write_state(state)
    old_value = self.__send__(self.class.aasm_column)
    self.__send__("#{self.class.aasm_column}=", state)

    success = if AASM::StateMachine[self.class].config.skip_validation_on_save
                self.class.where(self.class.primary_key => self.id).update_all(self.class.aasm_column => state.to_s) == 1
              else
                self.save
              end
    if success
      true
    else
      self.__send__("#{self.class.aasm_column}=", old_value)
      false
    end
  end

  def aasm_write_state_without_persistence(state)
    self.__send__("#{self.class.aasm_column}=", state)
  end

end

AASM::Base.module_eval do

  # Scopes need to be disabled. PowerEnum already provides this functionality
  def state(name, *args)
    state_without_scope(name, *args)
  end

end
