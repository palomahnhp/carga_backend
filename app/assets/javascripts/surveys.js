function initializeJS() {
  $("#errorTagCont").hide();
  $("#remove-task-box").hide();
  showTotal();
  setOtherTaskJS();
}

function showTotal() {
  total = 0;
  $.each($("input[name^='time_per_']"), function( index, value ) {
    if (value.value != "" && $.isNumeric(value.value)) {
      total = total + parseFloat(value.value);
    }
    value.value = Math.floor(value.value*100)/100;
  });
  $("#total").val(Math.floor(total*100)/100 + " %");
}

function formCheck() {
  validData = true;
  percSum = 0;
  $.each($("input[name^='time_per_']"), function( index, value ) {
    if (value.value == "" || !$.isNumeric(value.value)) {
      validData = false;
      showError("Debe responder todas las preguntas con formato numérico");
    } else {
      if (value.value < 0 || value.value > 100) {
        validData = false;
        showError("Los valores de porcentaje deben estar entre 0 y 100");
      } else {
        percSum = percSum + parseFloat(value.value);
        value.value = Math.floor(value.value*100)/100;
      }
    }
  });
  if (validData && percSum != 100) {
    validData = false;
    showError("El total de porcentajes de tiempo debe sumar 100%");
  }
  if (validData) {
    swal({
      title: "Completado",
      text: "Encuesta completada correctamente",
      type: "success",
      confirmButtonText: 'Continuar'
    }).then(function() {
      $("#survey-form").submit();
    });
  } else {
    return false;
  }
}

function showError(message) {
  $("#errorTag").html(message);
  $(window).scrollTop(0);
  $("#errorTagCont").show();
}

function setOtherTaskJS() {
  var numOthTasks = 1000;
  
  $("#add-task").click(function() {
    if($(".task-row").length < 3) {
      numOthTasks++;
      taskTemplate = '<tr class="task-row"><td style="width: 100%;"><input class="form-control input-sm" type="text" id="inputSmall" name="other_task_'+numOthTasks+'" placeholder="Otra tarea" required></td><td><input class="form-control input-sm" style="width: 100px;" type="number" name="time_per_'+numOthTasks+'" id="survey-input-'+numOthTasks+'" onchange="showTotal();" min="0" max="100" step="0.01"></td></tr>'
      $("#other-tasks").append(taskTemplate);
      $("#remove-task-box").show();
      if($(".task-row").length == 3) {
        $("#add-task-box").hide();
      }
    }
  })
  
  $("#remove-task").click(function() {
    if($(".task-row").length >= 1) {
      numOthTasks--;
      $(".task-row").last().remove();
      showTotal();
      $("#add-task-box").show();
      if ($(".task-row").length < 1) {
        $("#remove-task-box").hide();
      }
    }
  })
}