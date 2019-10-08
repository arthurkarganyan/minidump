module RoutesGenerator
  def self.call(path = "/pages")
    res = []

    entries = Dir.entries("app" + path).reject do |i|
      i == '.' || i == '..'
    end

    entries.each do |i|
      current_path = "#{path}/#{i}"
      if current_path == "/pages/index.vue"
        res << { path: "/", component: "/pages/index.vue" }
      elsif current_path != "/pages/app.vue"
        if i['.vue']
          folder = "app" + current_path.gsub(/\.vue\Z/, '')
          unless File.exists?(folder)
            if current_path.split('/').size == 3
              res << { path: "/#{i.gsub('.vue', '')}", component: current_path }
            else
              res << { path: "#{i.gsub('.vue', '')}", component: current_path }
            end
          end
        else
          component_path = File.exists?("app" + "#{path}/#{i}.vue") ? "#{path}/#{i}.vue" : "/components/empty-parent.vue"
          component_path.sub!(path, '') unless path == "/pages"
          to_path = (path == '/pages') ? "/#{i}" : i
          res << { path: to_path, component: component_path, children: RoutesGenerator.call(current_path) }
        end
      end
    end

    res
  end
end
