package brewers.delight;
import com.google.protobuf.Any;
import test.logic.CoffeeMaker.*;
import io.grpc.stub.StreamObserver;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import java.util.ArrayList;
import java.util.List;

public class CoffeeShopServiceImpl extends  CoffeeShopServiceGrpc.CoffeeShopServiceImplBase {

    @Override
    public void cleanCoffeeMachine(CoffeeCleaningRequest request, StreamObserver<CoffeeCleaningResponse> responseObserver) {
        String name = request.getName();
        String cleanedMode = request.getCleanMode();

       CoffeeMachine  coffeeMachine = CoffeeMachine.newBuilder()
                .setName(name)
                .setStatus("cleaned to " + cleanedMode)
                .setDateLastCleaned(cleanedDate()).build();

        //response
        CoffeeCleaningResponse response = CoffeeCleaningResponse.newBuilder()
                .setResult(coffeeMachine)
                .build();

        //set a response
        responseObserver.onNext(response);

        // complete the rpc call
        responseObserver.onCompleted();

    }

    @Override
   public void coffeeReady(HelloRequest request, StreamObserver<HelloResponse> responseObserver) {

      String order = request.getOrder();
      String clientName = request.getClientName();
      String result= "";

      HelloResponse.Builder response = HelloResponse.newBuilder();

      if(clientName.isEmpty()){
          result = "No name provided ";
          response.setReady(result);

      }else {

          //get the parameters and do with as you wish
          result = "Welcome back " + clientName + "! congratulations, your order of " + order + " is ready!";
          response.setReady(result);
      }

      //set a response
      responseObserver.onNext(response .build());

      // complete the rpc call
      responseObserver.onCompleted();
   }

    @Override
    public void makeCoffee(CoffeeInstructionsRequest request, StreamObserver<CoffeeResponse> responseObserver) {

        List<String> order = request.getIngredientsList();
        Any milk = request.getMilk();
        int sugarLumps = request.getSugarLumps();

        //get the parameters and do with as you wish
        List<String> result = new ArrayList<>();
        result.add(sugarLumps + "sugar lumps");

        result.addAll(order);

        AlmondMilkOuterClass.AlmondMilk almondMilk;
        if (milk.is(AlmondMilkOuterClass.AlmondMilk.class)) {
            try {
                almondMilk = milk.unpack(AlmondMilkOuterClass.AlmondMilk.class);
                result.add("Your " + almondMilk.getName() + "milk was processed at " + almondMilk.getProcessingPlant() + " and a standard portion is " + almondMilk.getMls() + " mls");
            }
            catch(Exception e) {
                System.out.println("an exception was thrown adding almond milk");
            }
        }

        FullFatMilkOuterClass.FullFatMilk fullFatMilk;
        if (milk.is(FullFatMilkOuterClass.FullFatMilk.class)) {
            try {
                fullFatMilk = milk.unpack(FullFatMilkOuterClass.FullFatMilk.class);
                result.add("Your " + fullFatMilk.getName() + "milk was farmed at " + fullFatMilk.getFarm() + " and a standard portion is " + fullFatMilk.getMls() + " mls");
            }
            catch(Exception e) {
                System.out.println("an exception was thrown adding almond milk");
            }
        }

        CoffeeResponse response = CoffeeResponse.newBuilder()
                .addAllOutputList(result)
                .build();

        //set a response
        responseObserver.onNext(response);

        // complete the rpc call
        responseObserver.onCompleted();
    }

    private String cleanedDate(){
        LocalDateTime currentDate = LocalDateTime.now();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return currentDate.format(dateFormatter);
    }
}
