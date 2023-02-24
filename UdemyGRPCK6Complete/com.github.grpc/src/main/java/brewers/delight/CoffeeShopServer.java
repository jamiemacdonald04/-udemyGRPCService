package brewers.delight;
import io.grpc.Server;
import io.grpc.ServerBuilder;
import java.io.IOException;


public class CoffeeShopServer {
    public static void main(String[] args) throws IOException, InterruptedException
    {
        Server server = ServerBuilder.forPort(50052)
                .addService(new CoffeeShopServiceImpl())
                .build();
        System.out.println("server starting....");
        server.start();
        System.out.println("server started.");

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.out.println("Shutting down server.");
            server.shutdown();
            System.out.println("Server shut down.");
        }));

        server.awaitTermination();
    }
}
