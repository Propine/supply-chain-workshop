# Supply Chain Workshop

Applying blockchain to solve supply chain problems.

## Use Case: Last mile delivery


### Creation of a delivery order

A contract that has a list of delivery orders and funds in it.

Owner can push delivery orders up


### Drivers taking up the order
Courier would bid for a list of delivery orders. Bidding creates a new contract with the courier.

### Driver updating the order statuses
Courier updates the contract with the delivery status

### When delivery is complete, driver gets the funds
Courier updates delivered status. Recipient updates as complete. Funds get transferred into Courier's account


DeliveryOrderRegistry.deployed().then((inst) => { registry = inst; })
DeliveryOrderBidder.deployed().then((inst) => { courier = inst; })
registry.addOrder("bishan", 100)
registry.orders(0).then((a) => {console.log(a.toString());})
registry.orderCount().then((a) => {console.log(a.toString());})
web3.eth.getBalance(registry.address).toString()
web3.eth.sendTransaction({from: web3.eth.accounts[0], value: web3.toWei(0.1), to: registry.address})
courier.bid(0, 90)
registry.orderBidderCount().then((a) => {console.log(a.toString());})
registry.orderBidders(0).then((a) => {console.log(a.toString());})
registry.awardOrder(0)
web3.eth.getBalance(courier.address).toString()
courier.addStatus("delivered")
courier.statuses(0).then((a) => {console.log(a.toString());})
registry.completeOrder(0)
