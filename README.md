
# BlockPay 


<p align="center">
<a href="https://dscommunity.in">
	<img src="https://github.com/oojas/BlockPay/blob/master/images/logo.png" width=20%/>
</a>
	<h2 align="center">Decentralised AI powered Money Lending Application</h2>
	
	
<br>

<p align="center">
	 
[Checkout the Project Demonstration and Explanation Video Here!]()


	 
</p>

## Preview
<img src="https://github.com/oojas/BlockPay/blob/master/images/Artboard%201.png" width=40%/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://github.com/oojas/BlockPay/blob/master/images/Artboard%202.png" width=40%/>
<br>
<br>
<br>
<img src="https://github.com/oojas/BlockPay/blob/master/images/Artboard%203.png" width=40%/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://github.com/oojas/BlockPay/blob/master/images/Artboard%204.jpg" width=40%/>

## Problem Statement:

There are numerous small businesses and entrepreneurs that are in dire need of money and investments but a lack of collateral or a bad credit score hinders the process of getting or applying for loans in banks and getting through with their formalities. That’s when they rely on local money lenders and investors. By the means of this project we not only generate a framework that creates a transparent working environment but also fosters an autonomous system that eliminates the need for explicit checking and passing of loans. Creating a safe and user friendly money lending milieu with almost no difficulty. 

## Our solution:
We have bolstered our block chain technologies with the undergirds of Machine learning and Artificial intelligence to formulate an elegant working framework that eliminates the opacity and grey area, making the transfer approval and passing of loans no more a recondite task.
We have used the data to create a machine learning powered predictor that uses certain functions and methods to formulate a predictor that in turn on the basis of the credit information of the user predicts if the user is credible for a loan or not.
That’s where blockchain comes in, the major concern with the traditional transactional recording systems of these local money lenders is that they might be a victim of or might be on the receiving end of some deception or malfeasance when it comes to money borrowing and lending. This transparent blockchain system eliminates the possibility of any such peccadilloes and inturn make an ironclad transfer system.
Thus our solution makes the money borrower credible by the machine learning model and the transactions safe and transparent by the blockchain systems served on an user friendly mobile application. Lending money has never been safer.

## Why are we using Blockchain?

Integrating blockchain into multiple aspects of the financial ecosystem is groundbreaking.One such innovation is simplifying peer to peer (P2P) transactions.Traditional P2P lending systems do not allow direct matching of lenders and borrowers.This is made possible through blockchain. Blockchain simplifies and secures peer to peer transactions along with reducing the time and making the process seamless. Blockchain,with it’s enhanced features, provides the stakeholders autonomy and increased security.

Identifying stakeholders in a P2P platform
The stakeholders include:
- Lenders
- Borrowers

## Functionalities

Securing a Loan

Borrower
- Borrowers can send requests to potential lenders through the blockchain
- The borrower can choose the amount, payment period and rate of interest according to his or her preferences from the proposals made by the lenders.
- The above is made possible as blockchain operates in a decentralized manner and  the proposals made are visible to everyone in the network
- This also increases the transparency as each stakeholder will have a copy of the ledger.


Lender
- Lenders can make proposals to lend money,specifying the amount,payment period and rate of interest.
- After the lender receives the request from the borrower,he/she can decide if the person is credible for a loan or not
- This is made possible through robust Machine Learning techniques.
- The application of Machine learning techniques eliminates the requirement of a third party for loan confirmation. It also eradicates the need for collateral. Thereby democratizing the lending process.

Repayment of Loan

Borrower
- Employing smart contracts automates the process of repayment. 
- The borrower can keep track of all his payments as the blockchain is immutable and all transactions from the genesis block are stored in the blockchain.
- As the borrower can keep track of the transactions made,it eliminates the probability of him being charged extra interest/ erroneous late fees.

Lender
- The lender can keep track of all the transactions as the ledger is shared and immutable.
- The history of transactions that are available acts as a digital ledger and makes the lending-repayment process seamless.

## Tech Stack

Blockchain

The platform uses the Ethereum network as it’s backend. 
Smart contracts were written using Solidity.
The testing of the contracts was done using Remix,Metamask and Ganache in the Injected Web Server environment. (simultaneously tried testing with Remix + Rinkeby Test Network)

Machine Learning

The loan approval predictor model was built using XGBoost. Various accuracy metrics were used to determine the accuracy of the predictions made by the model.
The serialized model was obtained through the pickle module
The API for the model was made using FastAPI

App Development

The app was developed using Flutter
The web3dart package was used to connect the app to the Ethereum Network.


## Future Prospects

In the aforementioned submission we have the working client side application for the money borrower. Also along that we have the working machine learning model, the complete blockchain transaction system and all the functionalities that could be possibly needed for such an environment. The aspects that we need to integrate is the ml and blockchain part with the built app.
Once we have that ready we plan on making this app public. How will that work?
The best part of this app is that the ml software it uses for prediction is extremely limber, that is the data of clients is enough to create a predictor just by adding the data in the software by the admin. This clearly implies that this is a high-end bank which has tougher credit rules or if it is a local money lender in a rural area that lends money to a more specific cohort we have it all covered. This extremely flexible app works with any system just adding the data of the previous customers and the transactions are safe, sound and transparent along with a loan approval predictor.
In the final strata of the project we aim at making it an ubiquitous system that is present on every nook and corner of the industry, and why shouldn’t it be? It certainly is credible for it.




A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
