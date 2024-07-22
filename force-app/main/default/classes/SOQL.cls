/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Michael Ncube
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    
    
    public with sharing class LeadService {

    public List<Lead> getAllLeads(){
        // Check if the current user has read access to the Lead object
        if (Schema.sObjectType.Lead.isAccessible()) {
        return [
                Select Id, LastName, Company, Phone, Email
                From Lead
            ];
        }
    }

        //
    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public with sharing class ContactService {

        public List<Contact> getContactsByFirstName(String firstName){
            return [
                Select Id, FirstName, LastName, AccountId, Phone, Email
                From Contact WHERE FirstName = :firstName
            ];
        }
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     //}
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public class ContactService {

    public List<Id> getContactIdsByLastName() {
        List<Contact> contacts = [ Select Id FROM Contact WHERE LastName IN ( 'Smith', 'Jones' ) ];
        List<Id> contactIds = new List<Id>();
        for(Contact contact : contacts) {
            contactIds.add(contact.Id);
            }
        return contactIds;
        }
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    
    public with sharing class OpportunityService {
        
        public List<Opportunity> getClosedWonOpportunitiesByAccountId(Id accountId) {
            // Perform the SOQL query to fetch closed-won opportunities for the given accountId
            List<Opportunity> opportunities = [
                SELECT Id, Name, StageName, CloseDate, Amount
                FROM Opportunity
                WHERE AccountId = :accountId AND StageName = 'Closed Won'
            ];
            
            // Return the list of opportunities
            return opportunities;
        }
    }
    

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public class AccountUtils {

    public Integer getAccountCount() {
        Integer accountCount = [SELECT COUNT() FROM Account];
        return accountCount;
        }
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public class TaskService {

        public Map<Id, Task> getTasksDueNextWeek() {
            // Get the current date and the date 7 days from now
            Date today = Date.today();
            Date nextWeek = today.addDays(7);
    
            // Query tasks that are due within the next 7 days
            List<Task> tasks = [
                SELECT Id, Subject, Status, ActivityDate
                FROM Task
                WHERE ActivityDate >= :today AND ActivityDate <= :nextWeek
            ];
    
            // Create a map of Task Id to Task records
            Map<Id, Task> taskMap = new Map<Id, Task>();
            for (Task task : tasks) {
                taskMap.put(task.Id, task);
            }
    
            return taskMap;
        }
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    
    public class ContactService {

        public List<Contact> getContactsByEmailDomain() {
            // Query to retrieve contacts with email domain 'example.com'
            List<Contact> contacts = [
                SELECT Id, FirstName, LastName, Email 
                FROM Contact 
                WHERE Email LIKE '%@example.com'
            ];
            return contacts;
        }
    }
    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String queryKeyword = '%' + keyword + '%';
    List<Opportunity> opportunities = [
        SELECT Id, Name
        FROM Opportunity
        WHERE Name LIKE :queryKeyword
    ];
        return opportunities; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public List<Case> getFilterCaseOrigins() {
        String soqlQuery = 'SELECT Id, CaseNumber, Origin FROM Case WHERE Origin != \'Web\' AND Origin != \'Email\' AND Origin != null';
    // Execute the SOQL query and store the result in a list
    List<Case> filteredCases = Database.query(soqlQuery);
        return filteredCases; // Replace null with the variable you used to store the result
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}    
    
    public class LeadService {

        public List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword) {
            // Construct the SOQL query
            String query = 'SELECT Id, Name, LeadSource, Title FROM Lead WHERE LeadSource = :leadSource OR Title LIKE \'%' + keyword + '%\'';
            // Execute the query and return the results
        List<Lead> leads = Database.query(query);
        return leads;
    }
}

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> contactLastNames = new List<String>();

        // Query the Contacts
        List<Contact> contacts = [SELECT LastName FROM Contact WHERE AccountId = :accountId];
        // Loop through each Contact and add the LastName to the list
        //for () {
        //    
        //}
        for (Contact contact : contacts) {
            contactLastNames.add(contact.LastName);
        }

        // Return the list of Contact LastNames
        return contactLastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        AggregateResult[] groupedResults = [
            SELECT SUM(Amount) totalRevenue
            FROM Opportunity
            WHERE StageName = :stage OR Amount > 10000
        ];

        // Retrieve the total revenue from the query result
        Decimal totalRevenue = (Decimal)groupedResults[0].get('totalRevenue');

        // Return the total revenue
        return totalRevenue != null ? totalRevenue : 0; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public List<Account> getFirstTenAccounts() {
        List<Account> accounts = [SELECT Id, Name FROM Account ORDER BY Name LIMIT 10];
        return accounts; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> highValueOpportunities = [
        SELECT Id, Name, Amount, CloseDate 
        FROM Opportunity 
        WHERE Amount > 100000 
        ORDER BY CloseDate 
        LIMIT 5
    ];
        return highValueOpportunities; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public List<Contact> getBirthdateContacts() {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Birthdate 
        FROM Contact 
        WHERE Birthdate != NULL 
        ORDER BY Birthdate DESC 
        LIMIT 3];
        return contacts; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public List<Case> getCasesWithStatus() {
        List<Case> cases = [
        SELECT Id, CaseNumber, Subject, Status, CreatedDate 
        FROM Case 
        WHERE Status = 'Open' 
        ORDER BY CreatedDate 
        LIMIT 10 
        OFFSET 5
    ];
        return cases; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();

        // Query the Cases
        List<Case> cases = [SELECT Id FROM Case WHERE AccountId = :accountId];
        // Loop through each Case and add the Id to the set
        //for () {
        //    
        //}
        for (Case c : cases) {
            caseIds.add(c.Id);
        }

        return caseIds; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for (Account acc : accounts) {
            accountIdsToNames.put(acc.Id, acc.Name);
        }

        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public String getAccountNameForContact(String contactId) {
        
        // Query the Contact
        List<Contact> contacts = [SELECT AccountId FROM Contact WHERE Id = :contactId];
        // Query the Account
        List<Account> accounts = [SELECT Name FROM Account WHERE Id = :contacts[0].AccountId];
        return contact.Account.Name; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        
        // Query the Account and related Opportunities
        List<Account> accounts =[
            SELECT Id, Name, 
            (SELECT Id, Name, StageName, CloseDate, Amount 
            FROM Opportunities) 
            FROM Account 
            WHERE Id = :accountId
        ];
        return accountId; // Replace null with the variable you used to store the result
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        List<Account> accounts = [SELECT BillingState FROM Account WHERE Id = :accountId LIMIT 1];

        // Store the Account's BillingState
        String accountBillingState = account.BillingState;

        // Query the Contacts
        List<Contact> matchingContacts = [SELECT Id, FirstName, LastName, MailingState FROM Contact WHERE MailingState = :accountBillingState];

        return matchingContacts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads

        // Create a set of email domains from the Leads

        // Loop through each Lead

            // Get the email from the Lead

            // Check if the email is not null

                // Add the email domain to the set
        // Query the Leads and extract email domains
        Map<String, String> emailDomainToLeadIdMap = new Map<String, String>();
        for (Lead lead : [SELECT Id, Email FROM Lead WHERE Id IN :leadIds AND Email != null]) {
        String email = lead.Email;
        if (email != null) {
            String emailDomain = email.substring(email.indexOf('@') + 1);
            emailDomainToLeadIdMap.put(emailDomain, lead.Id);
        }
        }
        // Check if there are any email domains to process
        if (emailDomainToLeadIdMap.isEmpty()) {
        return new List<Account>();
        }
        
        // Query the Accounts
        List<Account> matchingAccounts = [
        SELECT Id, Name, Website
        FROM Account
        WHERE Website != null
        AND Website IN :emailDomainToLeadIdMap.keySet()
        ];

        return matchingAccounts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> originalLineItems = 
        [SELECT Product2Id, UnitPrice, Quantity, TotalPrice, Description, PricebookEntryId 
        FROM OpportunityLineItem 
        WHERE OpportunityId = :origOppId];

        // Create a list to hold the new line items
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();

        // Generate a random number between 1 and 3
        Integer randomNumber;

        // Loop through each cloned Opportunity Id
        for(Id cloneOppId : cloneOppIds) {
            // Loop through each original line item
            for(OpportunityLineItem originalLineItem : originalLineItems) {
                // Clone the original line item and add the random number to the quantity
                OpportunityLineItem newLineItem = originalLineItem.clone(false, false, false, false);
                newLineItem.OpportunityId = cloneOppId;
                randomNumber = Math.round(Math.random() * 2) + 1; // Generates a random number between 1 and 3
                newLineItem.Quantity = originalLineItem.Quantity + randomNumber;
                
                // Add the new line item to the list
                newLineItems.add(newLineItem);
            }
        }
        // Insert the new line items
        if(!newLineItems.isEmpty()) {
            insert newLineItems;
        }
    }
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public List<Opportunity> getOpportunityDetailsForClosedWon() { 
        
        // Query the Opportunities
        List<Opportunity> opportunities = [
        SELECT Name, Account.Name, Owner.Name
        FROM Opportunity
        WHERE StageName = 'Closed Won'];

        return opportunities; // Replace null with the variable you used to store the result

    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();

        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : closedWonOpps) {
            accountIds.add(opp.AccountId);
        }

        // Query the Contacts
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds ORDER BY CreatedDate ASC];

        // Loop through each Contact and add the Account Id and Contact to the map
        Map<Id, Id> accountToContactMap = new Map<Id, Id>();
        for (Contact contact : contacts) {
            if (!accountToContactMap.containsKey(contact.AccountId)) {
                accountToContactMap.put(contact.AccountId, contact.Id);
            }
        }
        
        // Loop through each Opportunity and update the Primary_Contact__c field
        for (Opportunity opp : closedWonOpps) {
            if (accountToContactMap.containsKey(opp.AccountId)) {
                opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId);
            }
        }

                // Update the Opportunity primary contact from accountToContactMap


        // Update the Opportunities
        update closedWonOpps;
    }
}
