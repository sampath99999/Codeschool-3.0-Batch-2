var email = localStorage.getItem("email");
        $("#useremail").text(email);
        var isTableVisible = false;

        function buttonClick() {
            isTableVisible = !isTableVisible;
            toggleTableVisibility();
            getUserTasks();
        }

        function toggleTableVisibility() {
            const table = $("#user_task_details_table");
            if (isTableVisible) {
                table.removeClass('visually-hidden');
            } else {
                table.addClass('visually-hidden');
            }
        }

        function getUserTasks() {
            $.ajax({
                url: "http://localhost/code_school/test%201/backend/taskuser.php",
                method: "POST",
                data: { email: email },
                success: function (results) {
                    console.log(results);
                    var userDetails = results.data;
                    $('#user_task_table_store').empty();
                    userDetails.forEach(function (task) {
                        $('#user_task_table_store').append(
                            $('<tr>').append(
                                $('<td>').text(task.taskname),
                                $('<td>').text(task.statusname),
                                $('<td>').text(task.createdbyuserid),
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

        //----------------------------------------------------log out-----------------------------------------------------------------
        function logOut() {
            localStorage.removeItem("username");   
            location.href = "login.html";
            history.pushState(null, null, null);
        }