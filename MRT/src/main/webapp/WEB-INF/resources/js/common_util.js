var ctx = '${CTX}';
const CHART_COLORS = {
	yellow_green: 'rgb(76, 153, 0)',
	yellow: 'rgb(153, 153, 0)',
	orange: 'rgb(153, 76, 0)',
	margenta: 'rgb(153, 0, 0)',
	deep_blue: 'rgb(0, 34, 86)',
	cyon: 'rgb(0, 153, 153)',
	green: 'rgb(0, 153, 76)'
};

const NAMED_COLORS = [
	CHART_COLORS.yellow_green,
	CHART_COLORS.yellow,
	CHART_COLORS.orange,
	CHART_COLORS.margenta,
	CHART_COLORS.deep_blue,
	CHART_COLORS.cyon,
	CHART_COLORS.green,
];

function isNull(object){
    var res = false;
    if((object == undefined || object == null ||  (typeof object == 'string' && object  == '') || object.length == 0)){
        res = true;
    }
    return res;
}

function isNullReturn(val1,val2){
	var val = (isNull(val1))?val2:val1;
	return (isNull(val))?'':val;
}

function CommonForm(id){
    this.id = id
    var $form = null;
    if($('#'+id).length > 0){
        $form = $('#'+id);
    }else{
        $form = $("<form id='"+id+"' method='post'></form>");
    }
    $form.appendTo('body');
    this.setUrl = function(url){
        $('#'+this.id).attr('action',url);
    }
    this.addParam = function(name,value){
        $('#'+this.id).append("<input type='hidden' name='"+name+"' value='"+value+"'>");
    }
    this.submit = function(){
        $('#'+this.id).submit();
    }
}

function getContextPath() {
    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
}

function checkYear(year){
    var yearVal = year.val();
    var yearReg = /^(19[0-9][0-9]|20\d{2})$/;
    var res = false;
    if(!yearReg.test(yearVal)){
        alert("생년월일의 연도를 정확하게 입력해주세요.");
        year.focus();
        res = true;
    }
    return res;
}

function checkDay(day){
    var dayVal = day.val();
    var dayReg = /^(0[1-9]|[1-2][0-9]|3[0-1])$/;
    var res = false;
    if(!dayReg.test(dayVal)){
        alert("생년월일의 일을 정확하게 입력해주세요.");
        day.focus();
        res = true;
    }
    return res;
}


function addZero(value){
    var zero = String(0);
    var resStr = '';
    if(value >= 0 && value < 10){
        resStr = zero+String(value);
    }else{
        resStr = String(value);
    }

    return resStr;
}

function common_init(){
    //영문+숫자
    $(".onlyEngNum").keyup(function(){
        var inputVal = $(this).val();
        $(this).val(inputVal.replace( /[^0-9|a-zA-Z]/g, '' ))
    });

    //한글만 입력
    $(".onlyKor").keydown(function(event){
        return is_val('han',event, this)
    });

    //영문
    $(".onlyEng").keydown(function(){
        var inputVal = $(this).val();
        $(this).val(inputVal.replace( /[^a-zA-Z\s]/g, '' ))
    });

    //한글과영문
    $(".onlyKorEng").keydown(function(){
        return is_val('haneng',event, this)
    });

    //숫자만 입력
    $('.onlyNum').keydown(function(e){
        e = window.event || e || e.which;
        if(e.ctrlKey && e.keyCode == 8){
            return;
        }
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9]/gi,''));
    })
    //reflash
    if(false) {
        $("*").keydown(function (e) {
            e = window.event || e || e.which;
            if (
                (e.ctrlKey &&e.keyCode == 8)  //back
                || e.keyCode == 116    //F5
                || e.keyCode == 112    // F1 new
                || (e.ctrlKey && e.keyCode == 82) // ctrl+R
                || (e.ctrlKey && e.keyCode == 78) // ctrl + n
                || (e.shiftKey && e.keyCode == 121) //shift+F10
            ) {
                e.keyCode = 0;
                return false;
            }
        });
    }
    //right mouse
    if(false){
        $(document).on("contextmenu",function(e){return false;});
    }

    $('.dateFormat').each(function(){
        var dateFormat = $(this).text();
        if(dateFormat.length > 0){
            $(this).text(dateFormat.substring(5,7)+'월 '+dateFormat.substring(8,10)+'일');
        }
    });
    $('.dateFormatAddYear').each(function(){
        var dateFormatAddYear = $(this).text();
        if(dateFormatAddYear.length > 0){
            $(this).text(dateFormatAddYear.substring(0,4)+'년 '+dateFormatAddYear.substring(5,7)+'월 '+dateFormatAddYear.substring(8,10)+'일');
        }
    });
    $('.prefixZeroDot').each(function(){
       var prefixZeroDot = $.trim($(this).text());
       var prefixLoc = 0;
       if(prefixZeroDot.length > 0) {
           var count = 0;
           for (var i = (prefixZeroDot.length - 1); i >= 0; i--) {
               if (prefixZeroDot.substring(i, prefixZeroDot.length - count) != '0') {
                   if (prefixZeroDot.substring(i, prefixZeroDot.length - count) == '.') {
                       prefixLoc = i;
                   } else if (prefixZeroDot.substring(i, prefixZeroDot.length - count) == '-') {

                   } else {
                       prefixLoc = i + 1;
                   }
                   break;
               }
               count++;
           }
           if (prefixLoc != 0) {
               $(this).text(prefixZeroDot.substring(0, prefixLoc));
           }
       }
    });


}
function fnGetEvent(e) {
    if (navigator.appName == 'Netscape') {
        keyVal = e.which;   //Netscape, CHROME
    } else if (navigator.appName == 'Microsoft Internet Explorer'){
        keyVal = e.keyCode ;   //MS
    }
    else{
        keyVal = e.which ;   //OPERA
    }
    return keyVal;
}
//key 값 체크 함수 -Type: han,eng,no

var k= new Array();
k= [8,9,13,16, 17, 18, 20,35,36,37,38,39,40,46, 112,113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123];

function is_val(type, e, obj){
    keyVal=fnGetEvent(e);
    for (i=0; i<k.length; i++)
    {
        if( keyVal == k[i]) return true;
    }
    if(type=="han") {
        if( keyVal==229 || keyVal==197) return true;
        else return false;
    }
    else if(type=="eng"){
        if( 65 <= keyVal && keyVal <=90) return true;
        else return false;
    }
    else if(type=="haneng"){
        if( 65 <= keyVal && keyVal <=90 || keyVal==229 || keyVal==197) return true;
        else return false;
    }
    else if(type=="no"){
        if( (48 <= keyVal && keyVal <=57) || ( 96<=keyVal && keyVal <=105 ) ) return true;
        else return false;
    }
    else if(type=="engNo"){
        if (is_val("eng", e, obj) )return true;
        else if( is_val("no",e, obj) )  return true;
        alert("영어와 숫자만 입력이 가능합니다.");
        return false;
    }
}

// 모달 띄울 때 사용 modalOpen
function codeAppend(obj,filename){
    //$('#'+obj).load(filename);
    $.get(filename,function(data){
        obj.html(data);
    })
}

function loading(stat){
    if(stat == 'on'){
        $('#loading_wrap').attr("class","loading-wrap");
        $('#loading').attr("class","loading");
    }else{
        $('#loading').removeAttr("class");
        $('#loading_wrap').removeAttr("class");
    }
}

function openModal(param){
    loading('on');
    $.ajax({
        type:"GET",
        data:param,
        url:param.url+"Ajax",
        cache:"false",
        dataType:"html",
        success: function(html){
            var modalDiv = null;
            var modalClass = "modal";
            if(!isNull(param.width)){
                modalClass += " width"+param.width
            }
            if(!isNull($('#modalSpace'+param.modalNum))){
                closeModal(param.modalNum);
                sleep(100);
            }
            modalDiv = $('<div class="'+modalClass+'" id="modalSpace'+param.modalNum+'"></div>');

            modalDiv.on($.modal.BEFORE_BLOCK , function(event, modal) {
                loading('off');

            });
            modalDiv.on($.modal.AFTER_CLOSE, function(event, modal) {
                modalDiv.remove();
                if(!isNull(param.ckedit)){
                    if(param.ckedit){
                        location.reload();
                    }
                }
            });
            modalDiv.appendTo('body');
            modalDiv.html(html);
            modalDiv.modal({
                closeExisting: false,
                clickClose: false,
                showClose: true,
                escapeClose: false,
                fadeDuration: 100       //  fade effect 100 for a sec
            })
        },
        error: function (request,status,error) {
            // showAjaxError(request,status,error);
        },
        complete:function(){
            
        }
    })
    loading('off');
}

function closeModal(modalNum){
    $('#modalSpace'+modalNum).children('a[rel="modal:close"]').trigger("click");
}

function openTab(url){
    window.open(url);
}


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function changeRate(map){
    var exc_id = $('#exc_name option:selected').val();
    var form = new CommonForm('chgRateForm');
    form.addParam("exc_id",exc_id);
    if(!isNull(map)){
        map.forEach(function(value, key){
           if(key != 'exc_id'){
               form.addParam(key,value);
           }
        });
    }
    form.submit();
}

function imgError(image,ctx) {
    image.onerror = "";
    image.src = ctx+"/resources/image/no-image.png";
    return true;
}

function stringToDate(datetime){
    var parts = datetime.split(" ");
    var date = parts[0].split("-");
    var time = parts[1].split(":");
    return new Date(date[0],date[1],date[2],time[0],time[1],time[2]);
}

function dateToString(datetime){
	var year = datetime.getFullYear();
	var month = datetime.getMonth() + 1;
	var date = datetime.getDate();
	var hour = datetime.getHours();
	var minute = datetime.getMinutes();
	var second = datetime.getSeconds();
    return year + "-" + addZero(month) + "-" + addZero(date) + " " + addZero(hour) + ":" + addZero(minute) + ":" + addZero(second);
}

function dateEx(date,year,month,day,hour,minute,second){
	var d = ((typeof date) == 'string')?stringToDate(date):date;
	d.setYear(d.getYear() + year);
	d.setMonth(d.getMonth() + month);
	d.setDate(d.getDate() + day);
	d.setHours(d.getHours() + hour);
	d.setMinutes(d.getMinutes() + minute);
	d.setSeconds(d.getSeconds() + second);
	return ((typeof date) == 'string')?datetoString(d):d;
}

function sleep (delay) {
    var start = new Date().getTime();
    while (new Date().getTime() < start + delay);
}

function showAjaxError(request,status,error){
    // BEFORE DEPLOYMENT 주석 처리
    alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
}

function tableHighlight(target, beforeNum, afterNum, speed){
//    if(beforeNum < afterNum){
//        target.effect('highlight', {
//            color: '#cfffdd'
//        }, speed);
//    } 
    if(beforeNum > afterNum){
        target.effect('highlight', {
            color: '#ffcfcf'
        }, speed);
    }
}

function chartjs(div_id,chart_type,graph_cnt){
	//chart_type : bar , line
	
	var id = div_id.substring(div_id.length-1,div_id.length);
	var canvas = $('#'+div_id);
//	var term = v_map.get("term");
//	var graph_cnt = v_map.get("graph_cnt");
//	var previousY = (ctx) => ctx.index === 0 ? ctx.chart.scales.y.getPixelForValue(100) : ctx.chart.getDatasetMeta(ctx.datasetIndex).data[ctx.index - 1].getProps(['y'], true).y;
	
	var chart = [];
	var datasets = [];
	var y_scales = {};
	
	var d = new Date();
	var now = dateToString(d).substring(11,19);
	
	const animation = {
		x: {
			type: 'number',
			easing: 'linear',
			from: NaN
		}
	} ;
	
	for (var i = 0; i < graph_cnt; i++){
		var data = [];
//		var yAxisID = "y" + i;
//		eval("animation." + yAxisID + " = {type: 'number',easing: 'linear',from: previousY}");
//		eval("y_scales." + yAxisID + "= {min: 0, max: 1000, type: 'linear', display: true}");
		
		datasets.push({
			borderColor: NAMED_COLORS[(i + 4) % 7],
			backgroundColor: NAMED_COLORS[(i + 4) % 7],
			borderWidth: 1,
			radius: 1,
			data: data,
//			yAxisID: yAxisID
		});
	}
	
	const config = {
		type: chart_type,
		data: {
			datasets: datasets
		},
		options: {
//		animation,
			responsive: false,
			interaction: {
				intersect: false
			},
			plugins: {
				legend: false
			},
			scales: {
				y:{}
			}
		},
	};
	
	chart[id] = new Chart(canvas,config);
	
	if (chart_type == 'bar'){   // bar chart
		this.addDataToChart = function(label_arr,data_arr_list){
			for (var i = 0; i < data_arr_list.length; i++){
				var data_arr = data_arr_list[i];
				chart[id].data.datasets[i].label = label_arr[i];
				for ( var j = 0; j < data_arr.length; j++){
					if (i == 0){
						chart[id].data.labels.push(data_arr[j].KEY);
					}
//					chart[id].data.datasets[i].label = data_arr[j].KEY;
					chart[id].data.datasets[i].data.push(data_arr[j].VALUE);
				}
			}
		}
		this.removeDataFromChart = function(){
			chart[id].data.labels = [];
			chart[id].data.datasets.forEach((dataset) => {
				dataset.data = [];
			});
		}
	} else {  // line chart
		this.addDataToChart = function(label,data_arr){
			var cnt = 0;
			chart[id].data.labels.push(label);
			chart[id].data.datasets.forEach((dataset) => {
	//			console.log("x:"+label+",y:"+data_arr[cnt].VALUE+",label:"+data_arr[cnt].KEY)
				dataset.label = data_arr[cnt].KEY;
				dataset.data.push({x: label,y: data_arr[cnt].VALUE});
				cnt++;
			});
		}
		this.removeDataFromChart = function(){
			if(chart[id].data.labels.length > 10 * 60){
				chart[id].data.labels.shift();
				chart[id].data.datasets.forEach((dataset) => {
					dataset.data.shift();
				});
			}
		}
	}
	
	this.updateChart = function(){
		chart[id].update();
	}
	this.setMinMax = function(min,max){
		chart[id].config.options.scales.y.min = min;
		chart[id].config.options.scales.y.max = max;
	}
	this.getGraphCount = function(){
		return graph_cnt;
	}
	this.debug = function(){
		return chart[id];
	}
}

function refreshSessStmtTableHtml(list){
	var html = '';
	
	if (list.length > 0){
		for (var i = 0; i < list.length; i++){
			html += '<tr class="btn-none">';
			html += '<td class="txt-rt">' + isNullReturn(list[i].SESSION_ID) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].DB_USERNAME) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].MODULE) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].CLIENT_APP_INFO) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].COMM_NAME) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].ACTION) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].EVENT) + '</td>';
			html += '<td class="txt-rt">' + isNullReturn(list[i].TX_ID) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].ACTIVE) + '</td>';
			html += '<td class="txt-cnt">' + isNullReturn(list[i].STATE) + '</td>';
			html += '<td aria-label="' + isNullReturn(list[i].QUERY) + '">' + isNullReturn(list[i].QUERY).substring(0,30) + '</td>';
			html += '<td class="txt-rt">' + isNullReturn(list[i].COST) + '</td>';
			html += '<td class="txt-cnt" ';
			if(!isNull(list[i].QUERY_START_TIME)){
				html += 'aria-label="' + isNullReturn(list[i].QUERY_START_TIME) +'"';
			} 
			html += '>' + isNullReturn(list[i].QUERY_START_TIME).substring(11,19) + '</td>';
			html += '<td class="txt-rt">' + isNullReturn(list[i].USED_MEMORY) + '</td>';
			html += '<td class="txt-rt">' + isNullReturn(list[i].READ_PAGE) + '</td>';
			html += '<td class="txt-rt">' + isNullReturn(list[i].WRITE_PAGE) + '</td>';
			html += '<td class="txt-rt">' + isNullReturn(list[i].GET_PAGE) + '</td>';
			html += '<td class="txt-rt">' + isNullReturn(list[i].CREATE_PAGE) + '</td>';
//			html += '<td>' + isNullReturn(list[i].UNDO_READ_PAGE) + '</td>';
//			html += '<td>' + isNullReturn(list[i].UNDO_WRITE_PAGE) + '</td>';
//			html += '<td>' + isNullReturn(list[i].UNDO_GET_PAGE) + '</td>';
//			html += '<td>' + isNullReturn(list[i].UNDO_CREATE_PAGE) + '</td>';
			html += '<td class="txt-cnt" ';
			if(!isNull(list[i].IDLE_START_TIME)){
				html += 'aria-label="' + list[i].IDLE_START_TIME + '"';	
			}
			html += '>' + isNullReturn(list[i].IDLE_START_TIME).substring(11,19) + '</td>';
			html += '<td class="txt-cnt" ';
			if(!isNull(list[i].LAST_QUERY_START_TIME)){
				html += 'aria-label="' + list[i].LAST_QUERY_START_TIME + '"';	
			}
			html += '>' + isNullReturn(list[i].LAST_QUERY_START_TIME).substring(11,19) + '</td>';
			html += '<td class="txt-cnt" ';
			if(!isNull(list[i].LOGIN_TIME)){
				html += 'aria-label="' + list[i].LOGIN_TIME + '"';	
			}
			html += '>' + isNullReturn(list[i].LOGIN_TIME).substring(11,19) + '</td>';
			html += '</tr>';
		}
	} else {
		html = '<tr><td colspan="21">no rows selected.</td></tr>';
	}
	
	return html;
}



