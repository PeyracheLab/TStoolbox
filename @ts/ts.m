% function tsa = ts(t, varargin)
% Constructor of TS object
% A TS object represents a time series of events, usually spike trains.
% It is a subclass of tsd, with empty Data.
%
%  	USAGE
%  	ts = ts(t)
%
%  	INPUTS:
%  	t: a sorted (in ascending order) vertical vector of timestamps
%
% note that in case of constructor called with no arguments, ts() returns a tsd with NaN timestamps
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0 Luke Sjulson Aug 2017

classdef ts < tsd
    methods
        function tsa = ts(t, varargin)
            
            if nargin == 0
                t = [];
            end
            
            tsa@tsd(t, [], 'Name', 'spike train', varargin{:});

            
        end
    end
end

