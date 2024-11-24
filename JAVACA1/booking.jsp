<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Date & Time</title>
    <style>
        body {
    margin: 0; /* Remove default body margin */
    background-color: #f4f6f8;
    font-family: Arial, sans-serif;
}

        .main-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: calc(100vh - 60px); /* Full height minus navbar height */
}
        .container {
            background-color: #ffffff;
            width: 600px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
        }
        h1 {
            font-size: 24px;
            color: #333333;
            margin-bottom: 20px;
        }
        .calendar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .calendar .date-picker {
            width: 60%;
        }
        .calendar input[type="date"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #cccccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .time-slots {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .time-slot {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px;
            border: 1px solid #dddddd;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .time-slot:hover {
            background-color: #f0f8ff;
            border-color: #007bff;
        }
        .time-slot input[type="radio"] {
            display: none;
        }
        .time-slot label {
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            text-align: center;
        }
        .time-slot.selected {
            background-color: #007bff;
            color: #ffffff;
        }
        button {
            width: 100%;
            padding: 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<div class="main-container">
    <div class="container">
        <h1>Select a Date & Time</h1>

        <!-- Date Picker -->
        <div class="calendar">
            <div class="date-picker">
                <label for="date">Choose a Date:</label>
                <input type="date" id="date" name="date" required>
            </div>
        </div>

        <!-- Time Slots -->
        <div class="time-slots">
            <div class="time-slot" onclick="selectTime(this, '10:00am')">
                <input type="radio" id="time1" name="time" value="10:00am">
                <label for="time1">10:00am</label>
            </div>
            <div class="time-slot" onclick="selectTime(this, '11:00am')">
                <input type="radio" id="time2" name="time" value="11:00am">
                <label for="time2">11:00am</label>
            </div>
            <div class="time-slot" onclick="selectTime(this, '1:00pm')">
                <input type="radio" id="time3" name="time" value="1:00pm">
                <label for="time3">1:00pm</label>
            </div>
            <div class="time-slot" onclick="selectTime(this, '2:30pm')">
                <input type="radio" id="time4" name="time" value="2:30pm">
                <label for="time4">2:30pm</label>
            </div>
            <div class="time-slot" onclick="selectTime(this, '4:00pm')">
                <input type="radio" id="time5" name="time" value="4:00pm">
                <label for="time5">4:00pm</label>
            </div>
        </div>

        <!-- Hidden Form -->
        <form action="${pageContext.request.contextPath}/BookingServlet" method="post">
            <input type="hidden" id="selectedDate" name="selectedDate">
            <input type="hidden" id="selectedTime" name="selectedTime">
            <button type="button" onclick="submitForm()">Confirm</button>
        </form>
    </div>
    </div>

    <script>
        function selectTime(element, time) {
            // Deselect other time slots
            document.querySelectorAll('.time-slot').forEach(slot => slot.classList.remove('selected'));

            // Select the clicked time slot
            element.classList.add('selected');

            // Set the hidden field value
            document.querySelector('input[name="time"][value="' + time + '"]').checked = true;
        }

        function submitForm() {
            const date = document.getElementById('date').value;
            const time = document.querySelector('input[name="time"]:checked')?.value;

            if (!date || !time) {
                alert('Please select both a date and a time.');
                return;
            }

            // Set hidden input values
            document.getElementById('selectedDate').value = date;
            document.getElementById('selectedTime').value = time;

            // Submit the form
            document.forms[0].submit();
        }
    </script>
</body>
</html>





