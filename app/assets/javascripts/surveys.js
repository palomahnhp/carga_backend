$(document).on('turbolinks:load', function() {
  resizeBox();
});

$(window).ready(function() {
  resizeBox();
});

$( window ).resize(function() {
  resizeBox();
});

function resizeBox() {
  width = $(window).width()-60;
  $(".survey-panel-custom").css({'width': width});
}

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
      value.value = Math.round(value.value*100)/100;
    }
  });
  $("#total").val(Math.round(total*100)/100 + " %");
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
        if ($("input[name='time_per_1001']").val() < 5 || $("input[name='time_per_1002']").val() < 5 || $("input[name='time_per_1003']").val() < 5) {
          validData = false;
          showError("Los porcentajes de las tareas extra no pueden ser inferiores a 5");
        } else {
          if ($("input[name='other_task_1001']").val() == "" || $("input[name='other_task_1002']").val() == "" || $("input[name='other_task_1003']").val() == "") {
            validData = false;
            showError("Debe rellenar las descripciones de las funciones extra");
          } else {
            percSum = percSum + parseFloat(value.value);
            value.value = Math.round(value.value*100)/100;
          }
        }
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
  var numOthTasks = 0;
  
  $("#add-task").click(function() {
    if($(".task-row").length < 3) {
      if ($("#remove-task-1001").attr("id") == null) {
        numOthTasks = 1001;
      } else {
        if ($("#remove-task-1002").attr("id") == null) {
          numOthTasks = 1002;
        } else {
          if ($("#remove-task-1003").attr("id") == null) {
            numOthTasks = 1003;
          }
        }
      }
      taskTemplate = '<tr class="task-row">'+
                        '<td style="width: 100%;">'+
                          '<input class="form-control input-sm" type="text" id="inputSmall" name="other_task_'+numOthTasks+'" placeholder="Otra tarea" required>'+
                        '</td>'+
                        '<td>'+
                          '<input class="form-control input-sm" style="width: 100px;" type="number" name="time_per_'+numOthTasks+'" id="survey-input-'+numOthTasks+'" onchange="showTotal();" min="5" max="100" step="0.01">'+
                        '</td>'+
                        '<td>'+
                          '<button type="button" id="remove-task-'+numOthTasks+'" class="btn-danger bin-button">'+
                            '<i class="fa fa-trash-o" aria-hidden="true"></i>'+
                          '</button>'+
                        '</td>'+
                      '</tr>';
      $("#other-tasks").append(taskTemplate);
      $("button[id^='remove-task-']").click(function() {
        $(this).parent().parent().last().remove();
        showTotal();
        $("#add-task-box").show();
      });
      $("#remove-task-box").show();
      if($(".task-row").length == 3) {
        $("#add-task-box").hide();
      }
    }
  });
}