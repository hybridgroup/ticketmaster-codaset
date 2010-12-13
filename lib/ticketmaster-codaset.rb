require File.dirname(__FILE__) + '/codaset/codaset-api'

%w{ codaset ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
