package ${basePackageName}.${projectName}.admin.common.config;

import ${basePackageName}.${projectName}.core.config.MyConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Component
class WebConfigurer extends WebMvcConfigurerAdapter {
@Autowired
MyConfig bootdoConfig;

@Override
public void addResourceHandlers(ResourceHandlerRegistry registry) {
registry.addResourceHandler("/files/**").addResourceLocations("file:///"+bootdoConfig.getUploadPath());
}

}