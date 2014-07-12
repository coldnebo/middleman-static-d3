require 'base64'

module StaticD3Helpers
  
  def javascript_embed(js_path)
    contents = read_file("#{js_dir}/#{js_path}.js")
    data_uri = data_uri_encode(contents, "application/javascript")
    %{<script src="#{data_uri}"></script>}
  end

  def stylesheet_embed(css_path)
    contents = read_file("#{css_dir}/#{css_path}.css")
    data_uri = data_uri_encode(contents, "text/css")
    %{<link rel="stylesheet" type="text/css" href="#{data_uri}">}
  end

  def data_embed(data_path, var_name)
    contents = read_file("#{data_dir}/#{data_path}")
    contents.gsub!(/"/,'\"')
    contents.gsub!(/(\n|\n\r)/,'\n')
    contents = %{var #{var_name} = "#{contents}";}
    data_uri = data_uri_encode(contents, "application/javascript")
    %{<!-- data embedding: var #{var_name} = data from '#{data_path}' -->\n<script src="#{data_uri}"></script>}
  end

  def read_file(source_path)
    file = File.expand_path("../../source/#{source_path}", __FILE__)
    raise "File not found: #{file}" unless File.exists?(file)
    File.read(file)
  end

  def data_uri_encode(data, mime_type="text/plain")
    "data:" + mime_type + ";base64," + Base64.encode64(data).rstrip
  end

end
