# simplepay (Rails Amazon Simple Pay Interface)

## DESCRIPTION:

This gem provides a Rails 4 interface to the Amazon Simple Pay payment service.

## FEATURES/PROBLEMS:

Supports the following Amazon Simple Pay services:

* Standard
* Subscription
* Marketplace
* Donation

## SYNOPSIS:

Add simplepay to your Bundler Gemfile

```ruby
#in Gemfile

gem "simplepay-rails4", :require => 'simplepay'
```

Configure the gem with your Amazon Web Services credentials:

```ruby
#in config/initializers/simplepay.rb

Simplepay.aws_access_key_id     = 'MYAMAZONACCESSKEYID'
Simplepay.aws_secret_access_key = 'MYAMAZONSECRETACCESSKEY'
Simplepay.use_sandbox = true # defaulted to true
```

### Obtaining Amazon Web Services Credentials
    
1) Create an Amazon Payments Personal Account
    https://payments.amazon.com/sdui/sdui/basicaccount
    or on Sandbox:
    https://payments-sandbox.amazon.com/sdui/sdui/basicaccount

2) Create an Amazon Payments Business Account
    https://payments.amazon.com/sdui/sdui/premiumaccount
    or in the sandbox for testing 
    https://payments-sandbox.amazon.com/sdui/sdui/premiumaccount
    
3)  Create an Amazon Web Services Account  
    https://aws-portal.amazon.com/gp/aws/developer/registration/index.html

4)  Retrieve the Access Key ID and Secret Access Key
    https://aws-portal.amazon.com/gp/aws/developer/account/index.html?ie=UTF8&action=access-key

Note that the AWS Access Key ID and Secret Access Key is good for both testing in the sandbox and for production use.

### Generating your Simple Pay forms

Generally, this library will then be used directly from one (or more) of your 
views.  Depending on the type of Simple Pay service you're using (see 
Simplepay::Services), some form values will be required, while others may be 
optional.  This is done like so:

```
<%= simplepay_form_for(:standard, {
  :amount       => 10.95,
  :description  => "Profit!"
}) %>

<%= simplepay_form_for(:subscription, {
  :amount                 => 10.95,
  :description            => "MORE Profit!",
  :recurring_frequency    => "1 month"
}) %>
```

### Marketplace forms

Amazon Simple Pay Marketplace makes it easy to facilitate payments between
buyers and sellers, and to charge a fee for the transaction. If you're building
a marketplace application, your sellers must first agree to the policy that you
set. You can do this by specifying the Simplepay::Services::MarketplacePolicy
service:


```
<%= simplepay_form_for(:marketplace_policy, {
  :max_fixed_fee => 5.00,
  :max_variable_fee => 5,
  :return_url => 'http://yourservice.com',
  :reference_id => '1234567890'
}) %>
```

The user will be prompted to login to their Amazon account and accept the policy
you propose. After they complete the process, they'll be returned to the return_url
specified. Amazon will also provide a recipientEmail parameter that will contain
the seller email here (you may want to craft your return url so that it contains the
reference_id value and use this to 'acknowledge' a sellers consent and record their
Amazon recipient email address).

Only once this is done will you be able to offer marketplace checkout options for
that sellers items:

```
    <%= simplepay_form_for(:marketplace, {
      :amount                   => 34.95,
      :description              => "Mutual profit!",
      :recipient_email          => 'seller@gmail.com',
      :fixed_marketplace_fee    => 10.00,
      :variable_marketplace_fee => 5
    }) %>
```

## INSTALL:

    sudo gem install simplepay-rails4

