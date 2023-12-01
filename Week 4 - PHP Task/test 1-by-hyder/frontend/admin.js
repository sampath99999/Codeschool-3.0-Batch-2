var email = localStorage.getItem("email");
        $("#useremail").text(email); 
        $(document).ready(function () {
    $("#addTaskForm").submit(function (event) {
        event.preventDefault();
        sendTaskData();
    });

    var email = localStorage.getItem("email");
    var isTableVisible = false;

    $(".btn-tasks").on("click", function () {
        buttonClick();
    });

    function buttonClick() {
        isTableVisible = !isTableVisible;
        toggleTableVisibility();
        getTasks();  // Call getTasks function here
    }

    function toggleTableVisibility() {
        const table = $("#task_details_table");
        if (isTableVisible) {
            table.removeClass('visually-hidden');
        } else {
            table.addClass('visually-hidden');
        }
    }

    function getTasks() {
        $.ajax({
            url: "http://localhost/code_school/test%201/backend/taskadmin.php",
            method: "POST",
            data: { email: email },
            success: function (results) {
                console.log(results);
                var userDetails = results.data;
                $('#task_table_store').empty();
                userDetails.forEach(function (task) {
                    $('#task_table_store').append(
                        $('<tr>').append(
                            $('<td>').text(task.userid),
                            $('<td>').text(task.name),
                            $('<td>').text(task.taskname),
                            $('<td>').text(task.statusname),
                            $('<td>').text(task.creator_name)
                        )
                    );
                });
            },
            error: function (error) {
                console.error("Error fetching data:", error);
            },
        });
    }
});