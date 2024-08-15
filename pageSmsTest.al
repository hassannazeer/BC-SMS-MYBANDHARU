page 80100 "SMSTEST"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("SMS Group")
            {
                field(PhoneNumber; PhoneNumber)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Phone Number';
                }

                field(Message; Message)
                {
                    ApplicationArea = All;
                    Caption = 'Message';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendSMS)
            {
                ApplicationArea = All;
                Caption = 'Send SMS';
                trigger OnAction()
                var
                    SMSIntegration: Codeunit "SMS API Integration";
                begin
                    // Validate inputs
                    if (PhoneNumber = '') or (Message = '') then begin
                        Message('Please provide both a phone number and a message.');
                        exit;
                    end;

                    // Call the SendSMS procedure in the SMS API Integration codeunit
                    SMSIntegration.SendSMS(PhoneNumber, Message);
                    Message('SMS sent successfully to %1.', PhoneNumber);
                end;
            }

            action(CheckBalance)
            {
                ApplicationArea = All;
                Caption = 'Check Balance';
                trigger OnAction()
                var
                    SMSIntegration: Codeunit "SMS API Integration";
                    BalanceResponse: Text;
                begin
                    // Call the CheckBalance procedure in the SMS API Integration codeunit
                    BalanceResponse := SMSIntegration.CheckBalance();
                    Message('Current Balance: %1', BalanceResponse);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Initialize the PhoneNumber with a default value
        PhoneNumber := '9609819445';
    end;

    var
        PhoneNumber: Text[30];
        Message: Text[160];
}
