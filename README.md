# Food_Delivery_System
Below is the functionality introduction of my program:

## **Project Name**: Ugly Group Delivery

### **Team Members**
- Jiang Chen
- Lan Guangzhi
- Han Yu
- Liu Baipeng

### **Project Introduction**
Our platform is a food delivery service dedicated to providing the best delivery experience for our users. We deliver delicacies, medicines, daily necessities, and supermarket products, allowing users to conveniently and swiftly order what they need. We aim to offer the best user experience, implementing the highest standards in delivery so that our users can order with peace of mind, use our services confidently, and enjoy their meals happily.

### **Project Function Description**
Our vision is a comprehensive delivery platform, catering to merchants, riders, and users. We plan to design four platforms: 
1. User Platform
2. Merchant Platform
3. Rider Platform
4. Admin Backend

#### **Users**
##### Registration
- **Username**: 5-15 characters 
- **Password**: 5-15 characters, including uppercase, lowercase, and underscores
- **Phone Number**
- **Verification Code**
- **Security Questions**: Choose 3 out of 10

##### Login
- **Option 1**: Username and password (with verification code)
- **Option 2**: Phone number with verification code
- **Option 3**: Email with verification code

##### Orders
- Display user info, rider info, merchant info, and estimated delivery time
- Rate and review once the order is delivered

##### User Center
- **Order Details**:
  - Past Orders: View-only
  - Ongoing Orders: Details about the merchant, rider, and expected delivery time
- **Personal Profile**: Phone Number, Name, Birthdate, Address, Email (optional)
- **Password Change**: Requires old password, new password, and password confirmation
- **Wallet**: Coupons, Account Balance, Recharge, Bank Card Binding
- **Membership** (if time permits): Membership recharge, Renewal
- **Browsing History**: Previously viewed shops
- **Favorites**:
  - Add to Favorites (on product page): A star icon for easy addition
  - Remove from Favorites, Search Favorites
- **Shopping Cart**: Add products, Delete from cart, Edit products, Search products
- **Communication Platform** for Users, Riders, and Merchants (chatroom, if time permits)

#### **Merchant**
##### Registration
- **Merchant Username**: 5-15 characters 
- **Merchant Password**: 5-15 characters with uppercase, lowercase, and underscores
- **Shop Name**, **Shop Address**
- **Type of Business**: (e.g., Japanese/Korean Cuisine, Milk Tea/Juice, Pizza/Burger, Delicious Chinese Food)
- **Owner's Real Name**, **ID Number**, **Phone Number**
- **Shop Photo**, **Business License**

##### Login
- Requires username, password, and verification code

##### Merchant Center
- Update business details, change password, view user orders, see ratings, manage wallet, view rider details

##### Merchant Menu
- Add, Delete, Modify, and Search for dishes

##### Order Handling
- Accept or decline orders

#### **Rider**
##### Registration
- Requires name, phone number, verification code, ID number, username, and password

##### Login
- Requires username, password, and verification code

##### Rider Center
- **View profile** (no edits), **order platform**, **current and past orders**, **wallet**, and **rider ratings**

### **Admin Backend**
This role will be hardcoded directly into the database, so no operations related to addition or removal are expected.

Admins can manage all database entries, including but not limited to:
- **Users**, **Riders**, **Merchants**, **Orders**


## **How to use the program**: 
##### We used Tomcat 9.0.33 as our localhost server:
- in order to open the program, you first need to install tomcat 9.0.33, and then add the Tomcat configuration of the program
- ![image](https://github.com/ChenJiang03/Food_Delivery_System/assets/113125907/170e4c1a-9f47-4a8c-9db3-3927ace74190)
- Also, we have our own datebase and it will not be published as it contained some personal information about some users, however, you can find the database design table in the following link, you can add your own data into this database:

