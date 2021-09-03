pragma solidity 0.5.16;

contract Company {
    
    //Struct to store Order details
    struct Order {
        uint id;         //order id
        uint quantity;   //order quantity
        string status;   //order status
        string payment;  //order payment status
        uint cost;       //cost of order
        address buyer;   //address of buyer
    }

    // Array to store Placed Orders
    mapping(uint => Order) public placedOrders;
    
    //Array to store Completed Orders
    mapping(uint => Order) public completedOrders;


    uint public placedOrderCount;    //Count of placed orders
    uint public CompletedOrderCount; //Count of completed orders
    
    uint public price=100;           // Price of each Tshirt



    // Function to place orders, which takes quantity as input and creates an order
    function placeOrder (uint quantity) public {
        
        // Add order to placed orders Count
        placedOrderCount ++;
        placedOrders[placedOrderCount] = Order(placedOrderCount, quantity,"placed","pending",0,msg.sender);
    }
    
    // Function to accept the order, This can be accepted by the account with different address than buyer
    function acceptOrder (uint orderid) public returns(uint) {
        // Check the address of sender
        require(msg.sender!=placedOrders[orderid].buyer);
        
        // delete the order from placed array and add to completed orders
        CompletedOrderCount++;
        completedOrders[CompletedOrderCount] = placedOrders[orderid];
        completedOrders[CompletedOrderCount].status="completed";                                        //Update the status to completed
        completedOrders[CompletedOrderCount].cost=100*completedOrders[CompletedOrderCount].quantity;    //Update the cost of the order
        delete placedOrders[orderid];
        placedOrderCount --;
        
        return price*completedOrders[CompletedOrderCount].quantity;
    }
    function confirmPayment (uint orderid) public {
        // Check the address wheather the account confirming payment is same as the one placed order
        require(msg.sender==completedOrders[orderid].buyer);
        completedOrders[orderid].payment="Completed";   // Update the payment status to completed
    }
}
