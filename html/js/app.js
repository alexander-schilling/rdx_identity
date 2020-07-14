var Config;
$.getJSON( "./config/config.json", function( data ) {  
    Config = data;
});

var Language;
$.getJSON( "./config/language.json", function( data ) {  
    Language = data;
});

function formatNumber(num) {
    if (num === undefined) { return 0; }
    return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
}

function showHud() {
    $("#characterSelector").show(3000);
}

function hideHud() {
    $("#characterSelector").hide(3000);
}

function setupCharacterSelector() {
    $("#characterSelector").html('');

    var rows = Math.ceil(Config.MaxCharacters / Config.CharactersPerRow);
    for (let row = 1; row <= rows; row++) {
        $("#characterSelector").append(`<div id="row-` + row + `" class="pure-g"></div>`);

        for (let index = 1; index <= Config.CharactersPerRow; index++) {
            var currentCharacter = (index * row);

            $("#row-" + row).append(
                `<div class="character pure-u-1-` + Config.CharactersPerRow + `">
                    <div id="character-` + currentCharacter + `" class="characterContent">
                        <form id="form-character-` + currentCharacter + `" class="pure-form">
                            <div class="pure-g">
                                <div class="register pure-u-1">` + Language.Register + `</div>
                            </div>
                            <fieldset class="pure-group">
                                <input id="firstname" name="firstname" type="text" class="pure-input-1" placeholder="` + Language.Firstname + `" required maxlength="50" />
                                <input id="lastname" name="lastname" type="text" class="pure-input-1" placeholder="` + Language.Lastname + `" required maxlength="50" />
                            </fieldset>
                            <div class="pure-g">
                                <label for="sex-male" class="pure-radio pure-u-1-2">
                                    <input type="radio" id="sex-male" name="sex" value="M" checked> ` + Language.Male + `</label>
                                <label for="sex-female" class="pure-radio pure-u-1-2">
                                    <input type="radio" id="sex-female" name="sex" value="F"> ` + Language.Female + `</label>
                            </div>
                            <br>
                            <button type="submit" class="pure-button pure-button-primary" onclick="createCharacter(` + currentCharacter + `)">` + Language.CreateCharacter + `</button>
                        </form>
                    </div>
                </div>`
            );
        }
    }
}

function setupCharacter(data) {
    var uniqueId = data.id;
    var characterId = data.character_id;
    var accounts = JSON.parse(data.accounts);
    var job = data.job;
    var jobGrade = data.job_grade;
    var jobLabel = data.jobLabel;
    var firstname = data.firstname;
    var lastname = data.lastname;
    var sexImg;

    /*console.log(uniqueId);
    console.log(characterId);
    console.log(accounts.toString());
    console.log(job);
    console.log(jobGrade);
    console.log(jobLabel);
    console.log(firstname);
    console.log(lastname);*/

    if (data.sex == 'M') {
        sexImg = "img/male.png";
    } else {
        sexImg = "img/female.png";
    }

    $("#character-" + characterId).html(
        `<img class="sex pure-img" src="` + sexImg + `" />
        <div class="name">` + firstname + ' ' + lastname + `</div>
        <div class="uniqueId"><b>` + Language.UniqueId + `</b>: ` + uniqueId + `</div>
        <div class="job">` + jobLabel + `</div>
        <div class="money"><img src="img/money.png" />$` + formatNumber(accounts["money"]) + `</div>
        <div class="bank"><img src="img/bank.png" />$` + formatNumber(accounts["bank"]) + `</div>
        <div class="gold"><img src="img/gold.png" />` + formatNumber(accounts["gold"]) + `</div>
        <br>
        <button class="pure-button pure-button-primary" onclick="selectCharacter(` + characterId + `)">` + Language.Play + `</button>`
    );
}

function showCharacterSelector(characters) {
    showHud();
    setupCharacterSelector();

    characters.forEach(data => {
        setupCharacter(data);
    });
}

function createCharacter(characterId) {
    $("#form-character-" + characterId).submit(function() {
        var values = {};
        $.each($('#form-character-' + characterId).serializeArray(), function(i, field) {
            values[field.name] = field.value;
        });

        hideHud();
        $.post('http://rdx_identity/createCharacter', JSON.stringify({
            characterId: characterId,
            characterData: values
        }));
    });
}

function selectCharacter(characterId) {
    hideHud();
    $.post('http://rdx_identity/selectCharacter', JSON.stringify({
        characterId: characterId
    }));
}

$(document).ready(function() {
    window.onData = (data) => {
		switch (data.action) {
			case 'showCharacterSelector': {
				showCharacterSelector(data.characters);
				break;
            }
            case 'hideHud': {
                hideHud();
                break;
            }
		}
	};

	window.addEventListener('message', function(event) {
		onData(event.data);
	});
});
