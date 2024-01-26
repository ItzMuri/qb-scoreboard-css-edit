QBScoreboard = {};

$(document).ready(function () {
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "open":
        QBScoreboard.Open(event.data);
        break;
      case "close":
        QBScoreboard.Close();
        break;
    }
  });
});

QBScoreboard.Open = function (data) {
  $(".scoreboard-block").fadeIn(150);
  $("#total-players").html(
    "<p>" + data.players + " of " + data.maxPlayers + "</p>"
  );
  $("#total-cops").html(
    "<p>" + data.currentCops + "</p>"
  );
  $("#total-ems").html(
    "<p>" + data.currentAmbulance + "</p>"
  );
  $("#total-sasp").html(
    "<p>" + data.currentSasp + "</p>"
  );
  $("#total-saspr").html(
    "<p>" + data.currentSaspr + "</p>"
  );
  $("#total-bcso").html(
    "<p>" + data.currentBcso + "</p>"
  );
  $("#total-hayes").html(
    "<p>" + data.currentHayes + "</p>"
  );
  $("#total-tuner").html(
    "<p>" + data.currentTuner + "</p>"
  );

  $.each(data.requiredCops, function (i, category) {
    var beam = $(".scoreboard-info").find('[data-type="' + i + '"]');
    var status = $(beam).find(".info-beam-status");

    if (category.busy) {
      $(status).html('<i class="fas fa-clock"></i>');
    } if (data.currentCops >= category.minimum) {
      $(status).html('<i class="fas fa-check"></i>');
    } else {
      $(status).html('<i class="fas fa-times"></i>');
    }
  });
};

QBScoreboard.Close = function () {
  $(".scoreboard-block").fadeOut(150);
};
