<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../../header.jsp"%>   
 <%@ include file="../../petmedic_navbar.jsp"%>  
<!DOCTYPE html>
<html lang="en">
  <head>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
      crossorigin="anonymous"
    />
    <script
      src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
      integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
      integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
      integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
      crossorigin="anonymous"
    ></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      .chat-content {
        height: 350px;
        overflow-y: scroll;
      }
      .line {
        margin-top: 10px;
        display: flex;
      }
      .chat-box {
        background: #eee;
        padding: 5px;
        max-width: 300px;
      }
      .mine {
        margin-left: auto;
      }
    </style>
  </head>
  <body >
  
  
  <p>
  <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
    헤이톰
  </button>
</p>
<div class="collapse" id="collapseExample">
  <div class="card card-body">

<div class="container">
    <div class="chat-content" id="chatContent">
      <div class="line">
        <span class="chat-box">안녕하세요, 반갑습니다. 저는 AI닥터 톰캣입니다. 저에게 반려동물에 대한 궁금하신 점을 물어봐주세요.</span>
      </div>
      <div class="line">
        <span class="chat-box mine">**유의사항: 해당 페이지의 저작권은 에잇벳에 있으며 상업적, 교육적으로 사용 불가합니다. 사용에 의한 어떠한 책임도 지지않습니다.**</span>
      </div>
    </div>
    <div class="row">
      <input class="form-control col-11" class="chat-box" id="input" />
      <button class="btn col-1" id="send">전송</button>
    </div>
    </div>
     
    
    
<!--  <script type="module"> -->
<!--       import { Configuration, OpenAIApi } from "https://cdn.skypack.dev/openai"; -->
<!--       document.getElementById("send").addEventListener("click", function () { -->
<!--  			var input = document.getElementById("input").value; -->
<!--             var template = '<div class="line">' + -->
<!--                 '<span class="chat-box mine">' + input + '</span>' + -->
<!--                 '</div>';         -->

<!--         document.querySelector(".chat-content").insertAdjacentHTML("beforeend", template); -->
<!--         const configuration = new Configuration({ -->
<!--           apiKey: "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", -->
<!--         }); -->
<!--         const openai = new OpenAIApi(configuration); -->
<!--         openai -->
<!--           .createCompletion({ -->
<!--             model: "text-davinci-003", -->
<!--             prompt: document.querySelector("#input").value, -->
<!--             temperature: 0.5, -->
<!--             max_tokens: 500, -->
<!--             top_p: 1, -->
<!--             frequency_penalty: 0, -->
<!--             presence_penalty: 0, -->
<!--           }) -->
<!--           .then((result) => { -->
<!--             console.log(result.data.choices[0].text); -->

<%--             var template = `<div class="line"><span class="chat-box">${result.data.choices[0].text}</span></div>`; --%>
<!--             document.querySelector(".chat-content").insertAdjacentHTML("beforeend", template); -->
<!--           }); -->
<!--       }); -->
<!--     </script> -->



  </div>
</div>
  
    <%@ include file="../../footer.jsp"%>	
    <script type="module">
                import { Configuration, OpenAIApi } from "https://cdn.skypack.dev/openai";

                document.getElementById("send").addEventListener("click", function () {
  var input = document.getElementById("input").value;
  var template = `<div class="line">
    <span class="chat-box mine">${input}</span>
  </div>`;

  var chatContent = document.getElementById("chatContent");
  chatContent.insertAdjacentHTML("beforeend", template);

  const openai = axios.create();

  openai
    .post(
      "https://api.openai.com/v1/engines/davinci/completions",
      {
        prompt: input,
        temperature: 0.5,
        max_tokens: 500,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0,
      },
      {
        headers: {
          Authorization: "Bearer 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",
        },
      }
    )
    .then((response) => {
      console.log(response.data.choices[0].text);
      var responseTemplate = `<div class="line">
        <span class="chat-box">${response.data.choices[0].text}</span>
      </div>`;
      chatContent.insertAdjacentHTML("beforeend", responseTemplate);
    })
    .catch((error) => {
      console.error(error);
    });
});

            </script>
  </body>
  
</html>