require 'new_relic/agent/method_tracer.rb'
ApplicationController.class_eval do
    include NewRelic::Agent::MethodTracer
    add_method_tracer :update_current_user
    add_method_tracer :admin_user
end
FleetsController.class_eval do
    include NewRelic::Agent::MethodTracer
    add_method_tracer :check_fleet_id
    add_method_tracer :purge_fleets
    add_method_tracer :render
end
Fleet.class_eval do
    include NewRelic::Agent::MethodTracer
    add_method_tracer :access_by?
    add_method_tracer :admin?
    add_method_tracer :purge
    add_method_tracer :summarize
    add_method_tracer :new_reports?
    add_method_tracer :user_changes_since?
end
User.class_eval do
    include NewRelic::Agent::MethodTracer
    add_method_tracer :purge
    add_method_tracer :global_admin?
    add_method_tracer :in_fleet?
end
# Time.class_eval do
#   class << self
#     include NewRelic::Agent::MethodTracer
#     add_method_tracer :now
#   end
# end
