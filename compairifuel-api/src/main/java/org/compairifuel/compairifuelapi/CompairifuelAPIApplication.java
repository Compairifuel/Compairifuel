package org.compairifuel.compairifuelapi;

//import io.swagger.v3.oas.annotations.OpenAPIDefinition;
//import io.swagger.v3.oas.annotations.info.Info;
//import io.swagger.v3.oas.annotations.servers.Server;
import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

@ApplicationPath("/")
//@OpenAPIDefinition(info = @Info(
//        title = "Compairifuel API",
//        version = "1.0.0"
////        contact = @Contact(
////                name = "Phillip Kruger",
////                email = "phillip.kruger@phillip-kruger.com",
////                url = "http://www.phillip-kruger.com"
////        )
//),
//        servers = {
//                @Server(url = "/", description = "localhost")
//        }
//)
public class CompairifuelAPIApplication extends Application {

}