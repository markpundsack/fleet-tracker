module ReportsHelper
  def report_in_words(r)
    out = "#{r.char_name} in #{r.solar_system_name}"
    out += ", " + pluralize(r.reds,"red") unless (r.reds.nil? || r.reds==0)
    out += ", " + pluralize(r.neutrals, "neut") unless (r.neutrals.nil? || r.neutrals==0)
    out += ", clear" if r.clear?
    #out += "#{time_ago_in_words(r.updated_at)} ago"
    return out
  end
end
