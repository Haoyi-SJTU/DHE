% Compute the Jacobian matrix J for a functional expression
% Outputs:
%       Output 1: Symbolic expression
%       Output 2: Function handle
%       Output 3: Variables of function f (stored as a cell array; n × 1 dimension)
%       Output 4: If an input point x0 is provided, outputs the value obtained by substituting the point

function varargout=Jacobian(f,x, varargin)

    [~,f]=fx(f);
    n=nargin(f); % 找到输入参数个数
    df=[];        
    for i =1:n
        df1 = diff(f,x(i));
        df = [df,df1];
    end
%     J=matlabFunction(df);    
    varargout{1}=df;                       % 输出为符号表达式

end

% Converts a function expression written as a string into a function handle.
% 
% Input: 
%   f — The function expression (in string or symbolic form).
% Output: 
%   x — The variable(s) within function f.

function [x,f]=fx(f)
    if  ~isa(f,'sym') 
        if iscolumn(f)
            f=str2sym(f);
        else
            f=str2sym(f');
        end                 
    end 
    x=symvar(f);             % 搜寻函数中的符号变量
    f=matlabFunction(f);
end

function Jk=Jx(J,x,x0)
    n=nargin(matlabFunction(J));
    if n==0
        Jk=double(J);
    else
        a=symvar(J);  % 找雅可比矩阵中的符号变量
        for i=1:length(a)
            s=char(a(i));
            idx(i) = find(strcmp(x,s));
        end
        Jk = subs(J,a,x0(idx));
        Jk = double(Jk);
    end   
end


