import Vue from 'vue/dist/vue.common';
import VueSlideUpDown from 'vue-slide-up-down'

class CreateChar {
    constructor() {
        if (window.location.href.indexOf('create-character') > -1) {
            this.initScript();
        }
    }

    initScript() {
        window.vm = new Vue({
            el: "#creatorcharacter",
            components: {
                VueSlideUpDown
            },
            data: {
                showCreator: false,
                selectedMenu: 0,
                selectedMenu2: 0,
                selectedMenu3: 0,
                selectedOption: 0,
                selectedPage: 0,
                validation: {
                  charNameMin: 7,
                  charNameMax: 25,
                  usernameRegex: /[A-Z][a-z]{2,12}\s[A-Z][a-z]{2,12}/,
                  regexDate: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/
                },
                gender: 'mp_m_freemode_01',
                menu1: [{
                        name: "Parentes",
                        icon: "fas fa-user-friends",
                        options: [
                            {
                                show: true,
                                name: "Rosto do pai",
                                min: 0,
                                max: 20,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Cor de pele do Pai",
                                min: 0,
                                max: 20,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Rosto da Mãe",
                                min: 21,
                                max: 45,
                                value: 21
                            },
                            {
                                show: true,
                                name: "Cor de Pele da Mãe",
                                min: 0,
                                max: 20,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Predominancia de Rosto",
                                min: 0.0,
                                max: 1.0,
                                step: 0.05,
                                value: 0.5
                            },
                            {
                                show: true,
                                name: "Predominancia de Cor",
                                min: 0.0,
                                max: 1.0,
                                step: 0.05,
                                value: 0.5
                            },
                        ]
                    },
                    {
                        name: "Olhos",
                        icon: "fas fa-eye",
                        options: [{
                                show: true,
                                name: "Abertura do Olho",
                                min: -1,
                                max: 1,
                                step: 0.05,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Cor dos Olhos",
                                min: 0,
                                max: 31,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Sobrancelhas",
                                min: 0,
                                max: 33,
                                value: 0
                            },
                            {
                                show: false,
                                name: "Densidade da sobrancelha",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0.0
                            },
                            {
                                show: true,
                                name: "Cor das sobrancelhas",
                                min: 0,
                                max: 63,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Altura da sobrancelha",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0.0
                            },
                            {
                                show: true,
                                name: "Largura da sobrancelha",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0.0
                            },
                        ]
                    },
                    {
                        name: "Nariz",
                        icon: "medicinebody-big-nose",
                        options: [{
                                show: true,
                                name: "Largura do Nariz",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Altura do Nariz",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Comprimento do Nariz",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Cavidade Nasal",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Ponta do Nariz",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Curvatura do nariz",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Queixo",
                        icon: "bodyandfitness-077-chin",
                        options: [{
                                show: true,
                                name: "Comprimento do Queixo",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Posição do Queixo",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Largura do Queixo",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Forma do queixo",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Largura da Mandibula",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Altura da Mandibula",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Bochecha",
                        icon: "fas fa-user-friends",
                        options: [{
                                show: true,
                                name: "Altura da Bochecha",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Largura da Bochecha",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Tamanho da Bochecha",
                                min: -1,
                                max: 0.99,
                                step: 0.01,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Boca",
                        icon: "medicinebody-woman-lips",
                        options: [{
                            show: true,
                            name: "Lábios",
                            min: -1,
                            max: 0.99,
                            step: 0.01,
                            value: 0
                        }, ]
                    },
                    {
                        name: "Pescoço",
                        icon: "medicinebody-human-neck",
                        options: [{
                            show: true,
                            name: "Tamanho do pescoço",
                            min: -1,
                            max: 0.99,
                            step: 0.01,
                            value: 0
                        }, ]
                    },
                ],
                menu2: [{
                        name: "Marcas",
                        icon: "fontUser-024-face-scan",
                        options: [{
                                show: true,
                                name: "Aspecto",
                                min: -1,
                                max: 11,
                                value: -1
                            },
                            {
                                show: true,
                                name: "Pele",
                                min: -1,
                                max: 10,
                                value: -1
                            },
                            {
                                show: true,
                                name: "Sardas",
                                min: -1,
                                max: 17,
                                value: -1
                            },
                        ]
                    },
                    {
                        name: "Cabelo",
                        icon: "medicinebody-men-hair",
                        options: [{
                                show: true,
                                name: "Cabelo",
                                min: 0,
                                max: 38,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Cor do Cabelo",
                                min: 0,
                                max: 63,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Mechas",
                                min: 0,
                                max: 33,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Barba",
                        icon: "medicinebody-man-with-beard",
                        options: [{
                                show: true,
                                name: "Barba",
                                min: -1,
                                max: 28,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Cor da Barba",
                                min: 0,
                                max: 63,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Maquiagem",
                        icon: "fontMakeUp-women-lipstick",
                        options: [{
                                show: true,
                                name: "Blush",
                                min: -1,
                                max: 7,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Cor do Blush",
                                min: 0,
                                max: 63,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Baton",
                                min: -1,
                                max: 9,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Cor do Baton",
                                min: 0,
                                max: 63,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Maquiagem",
                                min: -1,
                                max: 71,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Velhice",
                        icon: "fontOldAge-014-old",
                        options: [{
                                show: true,
                                name: "Rugas",
                                min: -1,
                                max: 14,
                                value: -1
                            },
                            {
                                show: true,
                                name: "Grau das Rugas",
                                min: -1,
                                max: 14,
                                value: -1
                            },
                        ]
                    },
                    {
                        name: "Torso",
                        icon: "bodyandfitness-066-body",
                        options: [{
                                show: true,
                                name: "Pelo Corporal",
                                min: -1,
                                max: 16,
                                value: -1
                            },
                            {
                                show: true,
                                name: "Cor dos pelos",
                                min: 0,
                                max: 63,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Corpo",
                        icon: "fas fa-male",
                        options: [{
                                show: true,
                                name: "Manchas no corpo",
                                min: -1,
                                max: 11,
                                value: -1
                            },
                            {
                                show: true,
                                name: "Manchas no corpo 2",
                                min: 0,
                                max: 1,
                                value: 0
                            },
                        ]
                    },
                ],
                menu3: [
                    {
                        name: "Nome",
                        icon: "fas fa-id-card",
                        options: [
                            {
                                name: "Nome e Sobrenome",
                                value: "Coloque seu nome",
                                type: 'text'
                            },
                            {
                                name: "Idade",
                                value: "18",
                                type: 'text'
                            },
                        ]
                    },
                    {
                        name: "Jaqueta",
                        icon: "clothes-009-tuxedo",
                        options: [
                            {
                                show: true,
                                name: "Agasalho",
                                min: -1,
                                max: 331,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Textura",
                                min: 0,
                                max: 3,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Camisa",
                        icon: "clothes-017-shirt-5",
                        options: [
                            {
                                show: true,
                                name: "Camiseta",
                                min: -1,
                                max: 164,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Textura",
                                min: 0,
                                max: 3,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Torso",
                        icon: "clothes-003-shirt-7",
                        options: [
                            {
                                show: true,
                                name: "Torso",
                                min: -1,
                                max: 168,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Textura",
                                min: 0,
                                max: 3,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Calça",
                        icon: "clothes-025-trousers",
                        options: [
                            {
                                show: true,
                                name: "Calça",
                                min: -1,
                                max: 126,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Textura",
                                min: 0,
                                max: 3,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Sapato",
                        icon: "clothes-031-shoe",
                        options: [
                            {
                                show: true,
                                name: "Sapatos",
                                min: -1,
                                max: 95,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Textura",
                                min: 0,
                                max: 3,
                                value: 0
                            },
                        ]
                    },
                    {
                        name: "Acessorio",
                        icon: "clothes-047-hanger",
                        options: [
                            {
                                show: true,
                                name: "Acessorios",
                                min: -1,
                                max: 135,
                                value: 0
                            },
                            {
                                show: true,
                                name: "Textura",
                                min: 0,
                                max: 3,
                                value: 0
                            },
                        ]
                    },
                ],
                errors: {
                    charName: [],
                    date: []
                },
            },
            computed:{
            },
            methods: {
                changeMenu: function(index) {
                    this.selectedMenu = index;
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ camera: this.menu1[this.selectedMenu].name }));
                },
                changeMenu2: function(index) {
                    this.selectedMenu2 = index;
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ camera: this.menu2[this.selectedMenu2].name }));
                },
                changeMenu3: function(index) {
                    if(this.selectedMenu3 == 0){
                        if(this.validateStep()){
                            this.selectedMenu3 = index;
                            $.post("http://fcrp_creator/Changes", JSON.stringify({ camera: this.menu3[this.selectedMenu3].name }));
                        }
                    } else {
                        this.selectedMenu3 = index;
                        $.post("http://fcrp_creator/Changes", JSON.stringify({ camera: this.menu3[this.selectedMenu3].name }));
                    }
                },
                isActive: function(menuItem) {
                    return this.selectedMenu === menuItem
                },
                isActive2: function(menuItem) {
                    return this.selectedMenu2 === menuItem
                },
                isActive3: function(menuItem) {
                    return this.selectedMenu3 === menuItem
                },
                changeGender: function(gender) {
                    this.gender = gender;
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ gender: this.gender }));
                },
                changeAppearence: function(v){
                    if(this.selectedMenu == 0) { // appearence
                        this.apprChange()
                    } else if(this.selectedMenu == 1){ // eyes
                        if(this.menu1[this.selectedMenu].options[2].value == 0){
                            this.menu1[this.selectedMenu].options[3].show = false;
                        } else {
                            this.menu1[this.selectedMenu].options[3].show = true;
                        }
                        this.eyesChange();
                    } else if(this.selectedMenu == 2) {
                        this.noseChange();
                    } else if(this.selectedMenu == 3) {
                        this.chinChange();
                    } else if(this.selectedMenu == 4) {
                        this.cheekChange();
                    } else if(this.selectedMenu == 5) {
                        this.lipsChange();
                    } else if(this.selectedMenu == 6) {
                        this.neckChange();
                    }
                },
                changeStyle: function(v){
                    if(this.selectedMenu2 == 0){
                        $.post("http://fcrp_creator/StyleChange", JSON.stringify({ 
                            changeBrands: true,
                            complexionModel: this.menu2[this.selectedMenu2].options[0].value,
                            sundamageModel: this.menu2[this.selectedMenu2].options[1].value,
                            frecklesModel: this.menu2[this.selectedMenu2].options[2].value
                        }));
                    } else if(this.selectedMenu2 == 1){
                        $.post("http://fcrp_creator/StyleChange", JSON.stringify({ 
                            changeHair: true,
                            hairModel: this.menu2[this.selectedMenu2].options[0].value,
                            firstHairColor: this.menu2[this.selectedMenu2].options[1].value,
                            secondHairColor: this.menu2[this.selectedMenu2].options[2].value
                        }));
                    } else if(this.selectedMenu2 == 2){
                        $.post("http://fcrp_creator/StyleChange", JSON.stringify({ 
                            changeBeard: true,
                            beardModel: this.menu2[this.selectedMenu2].options[0].value,
                            beardColor: this.menu2[this.selectedMenu2].options[1].value,
                        }));
                    } else if(this.selectedMenu2 == 3){
                        $.post("http://fcrp_creator/StyleChange", JSON.stringify({ 
                            changeMake: true,
                            blushModel: this.menu2[this.selectedMenu2].options[0].value,
                            blushColor: this.menu2[this.selectedMenu2].options[1].value,
                            lipstickModel: this.menu2[this.selectedMenu2].options[2].value,
                            lipstickColor: this.menu2[this.selectedMenu2].options[3].value,
                            makeupModel: this.menu2[this.selectedMenu2].options[4].value,
                        }));
                    } else if(this.selectedMenu2 == 4){
                        $.post("http://fcrp_creator/StyleChange", JSON.stringify({ 
                            changeOld: true,
                            ageingModel: this.menu2[this.selectedMenu2].options[0].value,
                            ageingValue: this.menu2[this.selectedMenu2].options[1].value,
                        }));
                    } else if(this.selectedMenu2 == 5){
                        $.post("http://fcrp_creator/StyleChange", JSON.stringify({ 
                            changeChest: true,
                            chestModel: this.menu2[this.selectedMenu2].options[0].value,
                            chestColor: this.menu2[this.selectedMenu2].options[1].value,
                        }));
                    } else if(this.selectedMenu2 == 6){
                        $.post("http://fcrp_creator/StyleChange", JSON.stringify({ 
                            changeBlemishes: true,
                            blemishesModel: this.menu2[this.selectedMenu2].options[0].value,
                            blemishes2Model: this.menu2[this.selectedMenu2].options[1].value,
                        }));
                    }
                },
                openCreator: function(bool) {
                    this.showCreator = bool;
                    this.apprChange();
                },
                eyesChange: function(){
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ 
                        changeEye: true,
                        eyeOpening: this.menu1[this.selectedMenu].options[0].value,
                        eyeColors: this.menu1[this.selectedMenu].options[1].value,
                        eyebrows: this.menu1[this.selectedMenu].options[2].value,
                        eyebrowsdensy: this.menu1[this.selectedMenu].options[3].value,
                        eyebrowscor: this.menu1[this.selectedMenu].options[4].value,
                        eyebrowsHeight: this.menu1[this.selectedMenu].options[5].value,
                        eyebrowsWidth: this.menu1[this.selectedMenu].options[6].value,
                    }));
                },
                lipsChange: function(){
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ 
                        changeLips: true,
                        lips: this.menu1[this.selectedMenu].options[0].value
                    }));
                },
                chinChange: function(){
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ 
                        changeChin: true,
                        chinLength:this.menu1[this.selectedMenu].options[0].value,
                        chinPosition:this.menu1[this.selectedMenu].options[1].value,
                        chinWidth:this.menu1[this.selectedMenu].options[2].value,
                        chinShape:this.menu1[this.selectedMenu].options[3].value,
                        jawWidth:this.menu1[this.selectedMenu].options[4].value,
                        jawHeight:this.menu1[this.selectedMenu].options[5].value
                    }));
                },
                cheekChange: function(){
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ 
                        changeCheek: true,
                        cheekboneHeight:this.menu1[this.selectedMenu].options[0].value,
                        cheekboneWidth:this.menu1[this.selectedMenu].options[1].value,
                        cheeksWidth:this.menu1[this.selectedMenu].options[2].value
                    }));
                },
                neckChange: function(){
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ 
                        changeNeck: true,
                        neckWidth: this.menu1[this.selectedMenu].options[0].value
                    }));
                },
                noseChange: function(){
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ 
                        changeNose: true,
                        noseWidth: this.menu1[this.selectedMenu].options[0].value,
                        noseHeight: this.menu1[this.selectedMenu].options[1].value,
                        noseLength: this.menu1[this.selectedMenu].options[2].value,
                        noseBridge: this.menu1[this.selectedMenu].options[3].value,
                        noseTip: this.menu1[this.selectedMenu].options[4].value,
                        noseShift: this.menu1[this.selectedMenu].options[5].value,
                    }));
                },
                apprChange: function() {
                    $.post("http://fcrp_creator/Changes", JSON.stringify({ 
                        changeAppearence: true,
                        father: this.menu1[this.selectedMenu].options[0].value, 
                        shapeFather: this.menu1[this.selectedMenu].options[1].value, 
                        mother: this.menu1[this.selectedMenu].options[2].value, 
                        shapeMother: this.menu1[this.selectedMenu].options[3].value, 
                        similarity: this.menu1[this.selectedMenu].options[4].value, 
                        skinSimilarity: this.menu1[this.selectedMenu].options[5].value
                    }));
                },
                changePage: function(page){
                    this.selectedPage = page;
                },
                clearErrors: function() {
                  this.errors.charName = [];
                  this.errors.date = [];
                },
                showError: function(field, message) {
                  switch(field) {
                    case 'charname':
                      this.errors.charName.push(message);
                      break;
                    case 'date':
                      this.errors.date.push(message);
                      break;
                  }
                },
                validateStep: function() {
                    this.clearErrors();
          
                    if(this.selectedPage === 1) {
                        if(this.menu3[this.selectedMenu3].options[0].value.length < this.validation.charNameMin) {
                            this.errors.charName.push('O nome do personagem não é válido')
                            return false
                        }
                        if(!this.menu3[this.selectedMenu3].options[0].value.match(this.validation.usernameRegex)) {
                            this.errors.charName.push('O nome do personagem não é válido')
                            return false
                        }
                        if(this.menu3[this.selectedMenu3].options[1].value < 18 || this.menu3[this.selectedMenu3].options[1].value > 98 ) {
                            this.errors.date.push('Idade Inválida')
                            return false
                        }
                        if(!this.errors.charName.length &&!this.errors.date.length) {
                          return true;
                        }
                    }
                },
                changeClothes: function(){
                    if(this.selectedMenu3 == 1) {
                        this.jacketChange();
                    } else if(this.selectedMenu3 == 2) {
                        this.shirtChange();
                    } else if(this.selectedMenu3 == 3) {
                        this.torsoChange();
                    } else if(this.selectedMenu3 == 4) {
                        this.legsChange();
                    } else if(this.selectedMenu3 == 5) {
                        this.shoesChange();
                    } else if(this.selectedMenu3 == 6) {
                        this.acessoryChange();
                    }
                },
                jacketChange: function(){
                    $.post("http://fcrp_creator/ChangeClothes", JSON.stringify({ 
                        changeJacket: true,
                        id: this.menu3[this.selectedMenu3].options[0].value,
                        texture:this.menu3[this.selectedMenu3].options[1].value,
                    }));
                },
                shirtChange: function(){
                    $.post("http://fcrp_creator/ChangeClothes", JSON.stringify({ 
                        changeShirt: true,
                        id: this.menu3[this.selectedMenu3].options[0].value,
                        texture:this.menu3[this.selectedMenu3].options[1].value,
                    }));
                },
                torsoChange: function(){
                    $.post("http://fcrp_creator/ChangeClothes", JSON.stringify({ 
                        changeTorso: true,
                        id: this.menu3[this.selectedMenu3].options[0].value,
                        texture:this.menu3[this.selectedMenu3].options[1].value,
                    }));
                },
                legsChange: function(){
                    $.post("http://fcrp_creator/ChangeClothes", JSON.stringify({ 
                        changeLegs: true,
                        id: this.menu3[this.selectedMenu3].options[0].value,
                        texture:this.menu3[this.selectedMenu3].options[1].value,
                    }));
                },
                shoesChange: function(){
                    $.post("http://fcrp_creator/ChangeClothes", JSON.stringify({ 
                        changeShoes: true,
                        id: this.menu3[this.selectedMenu3].options[0].value,
                        texture:this.menu3[this.selectedMenu3].options[1].value,
                    }));
                },
                acessoryChange: function(){
                    $.post("http://fcrp_creator/ChangeClothes", JSON.stringify({ 
                        changeAcessory: true,
                        id: this.menu3[this.selectedMenu3].options[0].value,
                        texture:this.menu3[this.selectedMenu3].options[1].value,
                    }));
                },
                finishCreator: function(){
                    if(this.validateStep()) {
                        $.post("http://fcrp_creator/FinishedCreator", JSON.stringify({ charName: this.menu3[0].options[0].value, age: this.menu3[0].options[1].value }));
                    }
                }
            },
            mounted() {},
            created() {    
            }
        });
    }
}

window.addEventListener('message', function(event) {
    switch (event.data.action) {
        case "showCreator":
            window.vm.openCreator(true)
            $.post("http://fcrp_creator/Changes", JSON.stringify({ gender: this.gender }));
            break;
        case "closeCreator":
            window.vm.openCreator(false)
            break;
    }
});

const throttle = (func, limit) => {
    let inThrottle
    return (...args) => {
        if (!inThrottle) {
            func(...args)
            inThrottle = setTimeout(() => inThrottle = false, limit)
        }
    }
}

window.addEventListener("keydown", throttle(function(ev) {
    var input = $(ev.target);
    var num = input.hasClass('input-number');
    var _key = false;
    if (ev.which == 81) {
        if (num === false) {
            _key = "right"
        } else if (num) {
            input.val(parseInt(input.val()) - 1)
            inputChange(input, false)
        }
    }
    if (ev.which == 69) {
        if (num === false) {
            _key = "left"
        } else if (num) {
            input.val(parseInt(input.val()) + 1)
            inputChange(input, false)
        }
    }
    if (_key) {
        $.post('http://fcrp_creator/rotate', JSON.stringify({ key: _key }))
    }
}));


export default CreateChar;