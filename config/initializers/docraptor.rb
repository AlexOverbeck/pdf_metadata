DocRaptor.configure do |docraptor|
  docraptor.username = ENV['DOCRAPTOR']
end

$docraptor = DocRaptor::DocApi.new
