//
//  ViewController.m
//  eWAYPaymnet
//
//  Created by Mahmudul Hasan R@zib on 10/20/17.
//  Copyright © 2017 Matrix Solution. All rights reserved.
//

#import "ViewController.h"
#import "RapidAPI.h"
#import "ERProgressHud.h"

@interface ViewController () {
    
    __weak IBOutlet UITextField *cardNumTxtFld;
    __weak IBOutlet UITextField *cardHolderNameTxtFld;
    __weak IBOutlet UITextField *expiryMonth;
    __weak IBOutlet UITextField *expiryYear;
    __weak IBOutlet UITextField *cvnTxtFld;
}
    
    @end

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    - (Transaction *)getTRansactionDetails {
        Transaction *transaction = [[Transaction alloc] init];
        
        Customer *customerObj = [[Customer alloc] init];
        customerObj.Reference = @"A12345";
        customerObj.Title = @"Mr.";
        customerObj.FirstName = @"Nico";
        customerObj.LastName = @"Vulture";
        customerObj.CompanyName = @"All Web Pty Ltd";
        customerObj.JobDescription = @"Developer";
        customerObj.Phone = @"09 889 0986";
        customerObj.Mobile = @"09 889 0986";
        
        Address *customerAddress = [[Address alloc] init];
        customerAddress.Street1 = @"Level 5";
        customerAddress.Street2 = @"369 Queen Street";
        customerAddress.City = @"Sydney";
        customerAddress.State = @"NSW";
        customerAddress.PostalCode = @"2010";
        customerAddress.Country = @"au";
        
        customerObj.Address = customerAddress;
        
        CardDetails *cardDetails = [[CardDetails alloc] init];
        cardDetails.Name = cardHolderNameTxtFld.text;
        cardDetails.Number = cardNumTxtFld.text;
        cardDetails.ExpiryMonth = expiryMonth.text;
        cardDetails.ExpiryYear = expiryYear.text;
        cardDetails.CVN = cvnTxtFld.text;
        customerObj.CardDetails = cardDetails;
        
        transaction.Customer = customerObj;
        
        //payment
        Payment *payment = [[Payment alloc] init];
        payment.Payment = 100;
        payment.InvoiceNumber = @"Inv 21540";
        payment.InvoiceDescription = @"Individual Invoice Description";
        payment.InvoiceReference = @"513456";
        payment.CurrencyCode = @"AUD";
        
        transaction.Payment = payment;
        
        return transaction;
    }
    
- (IBAction)payButtonAction:(id)sender {
    
    [[ERProgressHud sharedInstance] show];
    Transaction *transaction = [self getTRansactionDetails];
    [RapidAPI submitPayment:transaction completed:^(SubmitPaymentResponse *submitPaymentResponse) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ERProgressHud sharedInstance] hide];
        });
        
        if(submitPaymentResponse.Status == Accepted) {
            NSLog(@"EWAY: Accepted");
            NSString *submissionID = submitPaymentResponse.SubmissionID;
            NSLog(@"SubmissionID ======= %@", submissionID);
            
        }
        else if (submitPaymentResponse.Status == Success) {
            // The API Call completed successfully.
            NSLog(@"EWAY: Success");
            NSString *submissionID = submitPaymentResponse.SubmissionID;
            NSLog(@"SubmissionID ======= %@", submissionID);
        }
        else if(submitPaymentResponse.Status == Error) {
            // An error occurred with the API Call.
            [RapidAPI userMessage:submitPaymentResponse.Errors Language:@"EN" completed:^(UserMessageResponse *userMessageResponse) {
                NSString *msg = [NSString stringWithFormat:@"%@ \n %@",userMessageResponse.Errors, userMessageResponse.Messages];
                NSLog(@"EWAY ERROR: %@",msg);
            }];
        }
    }];
}
    
    @end
