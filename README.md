# Online Course Management System

**GUCera** is an online course platform inspired by MOOCs like Coursera. The system supports course management, student-instructor interactions, assignment handling, payment, and certification. It was developed as a 3-milestone academic project to demonstrate full-stack skills in **ERD design**, **SQL programming**, and **ASP.NET development**.

---

## 🚧 Milestones

### 📌 Milestone 1: ERD & Database Design
- Designed the **Entity Relationship Diagram (ERD)** to model users (students, instructors, admins), courses, assignments, and feedback.
- Defined **entity relationships**, including many-to-many associations (e.g., students-courses, instructors-courses).
- Normalized schema and prepared initial database specifications.

### 📌 Milestone 2: SQL Tables & Procedures
- Implemented SQL scripts to create:
  - Tables for users, courses, certificates, assignments, feedback, and payments.
  - **Stored procedures** for:
    - Course creation, enrollment, grading, and certification
    - Promo code issuance and usage
    - Feedback, GPA, and rating calculations
- Enforced constraints for prerequisites, assignment weights, and certification uniqueness.

### 📌 Milestone 3: ASP.NET Frontend
- Built a multi-role system using **ASP.NET** (Web Forms or MVC):
  - **Admins**: Approve courses, issue promo codes
  - **Instructors**: Add course materials, assignments, and grade submissions
  - **Students**: Register, enroll, complete assignments, and receive certificates
- Implemented **authentication & role-based access control**.
- Integrated dynamic views to list courses, submit feedback, and manage user profiles.

---

## 🔑 System Features

### 👥 User Roles
- **Admin**: Accept/reject courses, assign promo codes
- **Instructor**: Upload materials, define assignments, grade submissions
- **Student**: Enroll in courses, complete assignments, get certificates, rate instructors

### 📚 Courses & Assignments
- Each course includes:
  - Description, credit hours, content (via URL), price, and prerequisites
  - 3 types of assignments: **Quizzes, Exams, Projects**
  - Assignment types have configurable **weights summing to 100%**
- Students' final grades are calculated using assignment weights

### 📈 Feedback & Ratings
- Students rate instructors and provide feedback for courses
- Instructors' average rating is calculated dynamically

### 💳 Payments & Promotions
- Students can add **multiple credit cards**
- Admins can issue **promo codes** with:
  - Expiry date
  - One-time use per student
  - Specific discount amount

### 📜 Certificates
- Issued automatically upon course completion
- Unique per student-course pair
- Includes **issue date**

---

## 🛠 Technologies Used

- **ASP.NET (C#)**
- **SQL Server** (Stored Procedures, Views, Triggers)
- **HTML/CSS + Bootstrap**
- **Entity-Relationship Design** (draw.io / dbdiagram.io)
- **Visual Studio** (IDE)

---

## 🖼️ Example Screens

- Course listing & details page
- Assignment submission form
- Admin dashboard for promo code issuance
- Instructor grading dashboard

---

## 🧑‍💻 Authors & Acknowledgments

- **Project by**: Mai Hussien   
- **University**: German University in Cairo (GUC)  
- **Course**: Database Systems

---

## 📌 Future Improvements

- Add email notifications for assignment grading and certificate issuance
- Migrate from ASP.NET Web Forms to **ASP.NET Core MVC**
- Add API endpoints for integration with mobile apps

---
