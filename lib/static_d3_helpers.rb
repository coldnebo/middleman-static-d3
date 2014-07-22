require 'base64'

module StaticD3Helpers
  
  def javascript_embed(js_resource)
    if build?
      js = data_uri("#{js_dir}/#{js_resource}.js", "application/javascript")
      %{<script src="#{js}"></script>}
    else
      javascript_include_tag js_resource
    end
  end

  def stylesheet_embed(css_resource)
    if build?
      css = data_uri("#{css_dir}/#{css_resource}.css", "text/css")
      %{<link rel="stylesheet" type="text/css" href="#{css}">}
    else
      stylesheet_link_tag css_resource
    end
  end

  def data_embed(data_path)
    contents = read_file("#{data_dir}/#{data_path}")
    # escape double quotes in data and convert possible newlines to newline escape.
    contents.gsub!(/"/,'\"')
    contents = reline(contents)
    # assign the variable var_name
    if data_path =~ /json$/
      contents = %{data_embed['#{data_path}'] = JSON.parse("#{contents}");}
    else
      contents = %{data_embed['#{data_path}'] = "#{contents}";}
    end
    # and bundle the script as a data_uri
    data_uri = data_uri_encode(contents, "application/javascript")
    %{<!-- data embedding: data_embed['#{data_path}'] -->\n<script src="#{data_uri}"></script>}
  end

  def data_uri(resource, mime_type)
    contents = read_file(resource)
    data_uri = data_uri_encode(contents, mime_type)
  end 

  def inline(data)
    data.gsub(/[\n\r]/, '')
  end

  private

  # needed for data embed
  def reline(data)
    data.gsub(/(\n|\r\n)/,'\n')
  end


  def resource_path(resource)
    file = File.expand_path("#{source_dir}/#{resource}", __FILE__)
    unless File.exists?(file)
      file = File.expand_path("#{source_dir}/../#{build_dir}/#{resource}", __FILE__)
    end
    file
  end

  def read_file(resource)
    file = resource_path(resource)
    raise "File not found: #{file}" unless File.exists?(file)
    File.read(file)
  end

  def data_uri_encode(data, mime_type="text/plain")
    "data:" + mime_type + ";base64," + Base64.encode64(data).rstrip
  end

end
