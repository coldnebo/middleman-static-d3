require 'base64'

module StaticD3Helpers
  
  def javascript_embed(js_path)
    js = data_uri("#{js_dir}/#{js_path}.js", "application/javascript")
    %{<script src="#{js}"></script>}
  end

  def stylesheet_embed(css_path)
    css = data_uri("#{css_dir}/#{css_path}.css", "text/css")
    %{<link rel="stylesheet" type="text/css" href="#{css}">}
  end

  def data_embed(data_path, var_name)
    contents = read_file("#{data_dir}/#{data_path}")
    # escape double quotes in data and convert possible newlines to newline escape.
    contents.gsub!(/"/,'\"')
    contents = inline(contents)
    # assign the variable var_name
    contents = %{var #{var_name} = "#{contents}";}
    # and bundle the script as a data_uri
    data_uri = data_uri_encode(contents, "application/javascript")
    %{<!-- data embedding: var #{var_name} = data from '#{data_path}' -->\n<script src="#{data_uri}"></script>}
  end

  def data_uri(source_path, mime_type)
    contents = read_file(source_path)
    data_uri = data_uri_encode(contents, mime_type)
  end 

  # needed for js context; js doesn't like unescaped newlines.
  def inline(data)
    data.gsub(/(\n|\n\r)/,'\n')
  end

  private

  def read_file(source_path)
    file = File.expand_path("../../source/#{source_path}", __FILE__)
    raise "File not found: #{file}" unless File.exists?(file)
    File.read(file)
  end

  def data_uri_encode(data, mime_type="text/plain")
    "data:" + mime_type + ";base64," + Base64.encode64(data).rstrip
  end

end
