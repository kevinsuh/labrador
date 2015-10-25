var CaseFilterFunction = ['upper', 'lower', 'snake', 'squish', 'camel', 'constant', 'title', 'capital', 'sentence', 'of', 'flip'];

var CaseFilter = angular.module('CaseFilter',[]);

CaseFilterFunction.forEach(function(f){
  CaseFilter.filter(f + 'Case',function(){
    return function(input, params){
      return Case[f](input, params);
    };
  });
});